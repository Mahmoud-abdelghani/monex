import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator_impl.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/usecases/delete_reminder_usecase.dart';

import 'add_reminder_test.dart';

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
  late DeleteReminderUsecase usecase;
  late MockNotificationService notificationService;
  late NotificationScheduleCalculator notificationScheduleCalculator;

  setUp(() {
    reminderRepository = MockReminderRepository();
    notificationService = MockNotificationService();
    notificationScheduleCalculator = NotificationScheduleCalculatorImpl();

    when(
      () => notificationService.scheduleNotification(any()),
    ).thenAnswer((_) async {});

    when(
      () => notificationService.cancelNotification(any()),
    ).thenAnswer((_) async {});

    usecase = DeleteReminderUsecase(
      reminderRepository: reminderRepository,
      notificationService: notificationService,
      notificationScheduleCalculator: notificationScheduleCalculator,
    );
  });

  test(
    'should delete a reminder, and cancel all scheduled notifications',
    () async {
      final oldReminder = ReminderEntity(
        id: 'reminder-id',
        title: 'title',
        amount: 400,
        frequency: ContributionPeriod.daily,
        deadline: DateTime(2026, 10, 10, 10, 30),
        scheduleDate: DateTime(2026, 10, 7, 10, 30),
      );

      when(
        () => reminderRepository.getReminderById('reminder-id'),
      ).thenAnswer((_) async => Right(oldReminder));
      when(
        () => reminderRepository.deleteReminder('reminder-id'),
      ).thenAnswer((_) async => Right(null));

      final result = await usecase('reminder-id');
      expect(result.isRight(), true);

      final cancelled = verify(
        () => notificationService.cancelNotification(captureAny()),
      ).captured.cast<String>();

      expect(cancelled.length, 4);
      expect(cancelled, [
        'reminder-id-2026-10-07T10:30:00.000',
        'reminder-id-2026-10-08T10:30:00.000',
        'reminder-id-2026-10-09T10:30:00.000',
        'reminder-id-2026-10-10T10:30:00.000',
      ]);

      verifyNever(() => notificationService.scheduleNotification(any()));
    },
  );

  test(
    'should not delete a reminder, and not cancel any scheduled notifications',
    () async {
      final oldReminder = ReminderEntity(
        id: 'reminder-id',
        title: 'title',
        amount: 400,
        frequency: ContributionPeriod.daily,
        deadline: DateTime(2026, 10, 10, 10, 30),
        scheduleDate: DateTime(2026, 10, 7, 10, 30),
      );

      when(
        () => reminderRepository.getReminderById('reminder-id'),
      ).thenAnswer((_) async => Left(NotificationFailure('error')));
      when(
        () => reminderRepository.deleteReminder('reminder-id'),
      ).thenAnswer((_) async => Right(null));

      final result = await usecase('reminder-id');
      expect(result.isRight(), false);

      verifyNever(() => notificationService.cancelNotification(any()));

      verifyNever(() => reminderRepository.deleteReminder('reminder-id'));

      verifyNever(() => notificationService.scheduleNotification(any()));
    },
  );

  test(
    'should not delete a reminder, failure while canceling notifications',
    () async {
      final oldReminder = ReminderEntity(
        id: 'reminder-id',
        title: 'title',
        amount: 400,
        frequency: ContributionPeriod.daily,
        deadline: DateTime(2026, 10, 10, 10, 30),
        scheduleDate: DateTime(2026, 10, 7, 10, 30),
      );

      when(
        () => reminderRepository.getReminderById('reminder-id'),
      ).thenAnswer((_) async => Right(oldReminder));
      when(
        () => reminderRepository.deleteReminder('reminder-id'),
      ).thenAnswer((_) async => Right(null));

      when(
        () => notificationService.cancelNotification(any()),
      ).thenThrow(Exception('error'));

      final result = await usecase('reminder-id');
      expect(result.isRight(), false);

      verifyNever(() => reminderRepository.deleteReminder('reminder-id'));

      verifyNever(() => notificationService.scheduleNotification(any()));
    },
  );

  test(
    'should not delete a reminder, failure while canceling second notification',
    () async {
      final oldReminder = ReminderEntity(
        id: 'reminder-id',
        title: 'title',
        amount: 400,
        frequency: ContributionPeriod.daily,
        deadline: DateTime(2026, 10, 10, 10, 30),
        scheduleDate: DateTime(2026, 10, 7, 10, 30),
      );

      when(
        () => reminderRepository.getReminderById('reminder-id'),
      ).thenAnswer((_) async => Right(oldReminder));
      when(
        () => reminderRepository.deleteReminder('reminder-id'),
      ).thenAnswer((_) async => Right(null));

      when(
        () => notificationService.cancelNotification(
          'reminder-id-2026-10-08T10:30:00.000',
        ),
      ).thenThrow(Exception('error'));

      final result = await usecase('reminder-id');
      expect(result.isRight(), false);

      verify(
        () => notificationService.cancelNotification(
          'reminder-id-2026-10-07T10:30:00.000',
        ),
      );

      verify(
        () => notificationService.cancelNotification(
          'reminder-id-2026-10-08T10:30:00.000',
        ),
      );

      verifyNever(
        () => notificationService.cancelNotification(
          'reminder-id-2026-10-09T10:30:00.000',
        ),
      );

      verifyNever(() => reminderRepository.deleteReminder('reminder-id'));

      final reScheduled = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();

      expect(reScheduled.length, 1);
      expect(reScheduled.first.id, 'reminder-id-2026-10-07T10:30:00.000');
    },
  );

  test(
    'should not cancel any notification or actually it will rescheduling them, because of deleteing reminder failure',
    () async {
      final oldReminder = ReminderEntity(
        id: 'reminder-id',
        title: 'title',
        amount: 400,
        frequency: ContributionPeriod.daily,
        deadline: DateTime(2026, 10, 10, 10, 30),
        scheduleDate: DateTime(2026, 10, 7, 10, 30),
      );

      when(
        () => reminderRepository.getReminderById('reminder-id'),
      ).thenAnswer((_) async => Right(oldReminder));
      when(
        () => reminderRepository.deleteReminder('reminder-id'),
      ).thenAnswer((_) async => Left(NotificationFailure('error')));

      final result = await usecase('reminder-id');
      expect(result.isRight(), false);

      final cancelled = verify(
        () => notificationService.cancelNotification(captureAny()),
      ).captured.cast<String>();

      expect(cancelled.length, 4);
      expect(cancelled, [
        'reminder-id-2026-10-07T10:30:00.000',
        'reminder-id-2026-10-08T10:30:00.000',
        'reminder-id-2026-10-09T10:30:00.000',
        'reminder-id-2026-10-10T10:30:00.000',
      ]);

      final reScheduled = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();

      expect(reScheduled.length, 4);

      final ids = reScheduled.map((e) => e.id).toList();
      expect(ids, [
        'reminder-id-2026-10-07T10:30:00.000',
        'reminder-id-2026-10-08T10:30:00.000',
        'reminder-id-2026-10-09T10:30:00.000',
        'reminder-id-2026-10-10T10:30:00.000',
      ]);
    },
  );
}
