import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator_impl.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';
import 'package:monex/features/reminders/domain/usecases/add_reminder_usecase.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
      ReminderEntity(
        id: 'fallback-id',
        title: 'fallback-title',
        amount: 0,
        frequency: ContributionPeriod.none,
        deadline: DateTime(2099, 1, 1),
        scheduleDate: DateTime(2099, 1, 1),
      ),
    );

    registerFallbackValue(
      NotificationRequest(
        id: 'fallback-id',
        title: 'fallback-title',
        body: 'fallback-body',
        scheduleDate: DateTime(2099, 1, 1),
        recurrence: NotificationRecurrence.none,
        endDate: DateTime(2099, 1, 1),
      ),
    );
  });
  late MockReminderRepository reminderRepository;
  late AddReminderUsecase usecase;
  late MockNotificationService notificationService;
  late NotificationScheduleCalculator notificationScheduleCalculator;

  setUp(() {
    reminderRepository = MockReminderRepository();
    notificationService = MockNotificationService();
    notificationScheduleCalculator = NotificationScheduleCalculatorImpl();

    when(
      () => reminderRepository.addReminder(any()),
    ).thenAnswer((_) async => right(null));

    when(
      () => notificationService.scheduleNotification(any()),
    ).thenAnswer((_) async {});

    when(
      () => notificationService.cancelNotification(any()),
    ).thenAnswer((_) async {});

    usecase = AddReminderUsecase(
      reminderRepository: reminderRepository,
      notificationService: notificationService,
      notificationScheduleCalculator: notificationScheduleCalculator,
    );
  });

  test(
    'should schedule exactly one notification for a one-time reminder',
    () async {
      final scheduleDate = DateTime(2026, 10, 10, 10, 30);
      final deadline = DateTime(2026, 10, 10, 18, 00);

      final result = await usecase(
        title: 'Pay bill',
        amount: 500,
        frequency: ContributionPeriod.none,
        scheduleDate: scheduleDate,
        deadline: deadline,
      );

      expect(result.isRight(), true);

      final captured = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured;

      expect(captured.length, 1);

      final request = captured.first as NotificationRequest;

      expect(request.scheduleDate, deadline);
      expect(request.recurrence, NotificationRecurrence.none);

      verifyNever(() => notificationService.cancelNotification(any()));
    },
  );
  test(
  'should schedule all daily occurrences until the deadline',
  () async {
    final scheduleDate = DateTime(2026, 10, 5, 10, 30);
    final deadline = DateTime(2026, 10, 8, 10, 30);

    final result = await usecase(
      title: 'Daily reminder',
      amount: 100,
      frequency: ContributionPeriod.daily,
      scheduleDate: scheduleDate,
      deadline: deadline,
    );

    expect(result.isRight(), true);

    final captured = verify(
      () => notificationService.scheduleNotification(captureAny()),
    ).captured;

    expect(captured.length, 4);

    final requests =
        captured.map((e) => e as NotificationRequest).toList();

    expect(
      requests.map((e) => e.scheduleDate),
      [
        DateTime(2026, 10, 5, 10, 30),
        DateTime(2026, 10, 6, 10, 30),
        DateTime(2026, 10, 7, 10, 30),
        DateTime(2026, 10, 8, 10, 30),
      ],
    );

    expect(
      requests.map((e) => e.recurrence),
      everyElement(NotificationRecurrence.daily),
    );
  },
);

test(
  'should cancel already scheduled notifications when scheduling fails',
  () async {
    var callCount = 0;

    when(
      () => notificationService.scheduleNotification(any()),
    ).thenAnswer((invocation) async {
      callCount++;

      if (callCount == 3) {
        throw Exception('Scheduling failed');
      }
    });

    final result = await usecase(
      title: 'Test reminder',
      amount: 100,
      frequency: ContributionPeriod.daily,
      scheduleDate: DateTime(2026, 10, 5, 10, 30),
      deadline: DateTime(2026, 10, 8, 10, 30),
    );

    expect(result.isLeft(), true);
    expect(result, isA<Left<Failure, void>>());

    verify(
      () => notificationService.scheduleNotification(any()),
    ).called(3);

    verify(
      () => notificationService.cancelNotification(any()),
    ).called(2);
  },
);

test(
  'should return the original scheduling failure even if cleanup fails',
  () async {
    var scheduleCallCount = 0;

    when(
      () => notificationService.scheduleNotification(any()),
    ).thenAnswer((_) async {
      scheduleCallCount++;

      if (scheduleCallCount == 3) {
        throw Exception('Scheduling failed');
      }
    });

    when(
      () => notificationService.cancelNotification(any()),
    ).thenAnswer((_) async {
      throw Exception('Cleanup failed');
    });

    final result = await usecase(
      title: 'Test reminder',
      amount: 100,
      frequency: ContributionPeriod.daily,
      scheduleDate: DateTime(2026, 10, 5, 10, 30),
      deadline: DateTime(2026, 10, 8, 10, 30),
    );

    expect(result.isLeft(), true);

    verify(
      () => notificationService.scheduleNotification(any()),
    ).called(3);

    verify(
      () => notificationService.cancelNotification(any()),
    ).called(2);
  },
);
}

class MockNotificationService extends Mock implements NotificationService {}

class MockReminderRepository extends Mock implements ReminderRepository {}
