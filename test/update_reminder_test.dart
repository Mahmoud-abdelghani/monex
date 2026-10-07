import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator_impl.dart';
import 'package:monex/features/budget/domain/usecase/update_budget_usecase.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:monex/features/reminders/domain/usecases/update_reminder_usecase.dart';

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
  late UpdateReminderUsecase usecase;
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

    usecase = UpdateReminderUsecase(
      reminderRepository: reminderRepository,
      notificationService: notificationService,
      notificationScheduleCalculator: notificationScheduleCalculator,
    );
  });

  test(
    'should update reminder, cancel old notifications, and schedule new notifications',
    () async {
      // Arrange

      final oldReminder = ReminderEntity(
        id: 'reminder-1',
        title: 'Old title',
        amount: 100,
        frequency: ContributionPeriod.daily,
        scheduleDate: DateTime(2026, 10, 10, 10, 30),
        deadline: DateTime(2026, 10, 12, 10, 30),
      );

      final newScheduleDate = DateTime(2026, 10, 15, 10, 30);
      final newDeadline = DateTime(2026, 10, 17, 10, 30);

      when(
        () => reminderRepository.getReminderById('reminder-1'),
      ).thenAnswer((_) async => right(oldReminder));

      when(
        () => reminderRepository.updateReminder(any()),
      ).thenAnswer((_) async => right(null));

      // Act

      final result = await usecase(
        id: 'reminder-1',
        title: 'New title',
        amount: 200,
        frequency: ContributionPeriod.daily,
        scheduleDate: newScheduleDate,
        deadline: newDeadline,
      );

      // Assert

      expect(result.isRight(), true);

      // 1. Make sure the old reminder was requested.
      verify(() => reminderRepository.getReminderById('reminder-1')).called(1);

      // 2. Make sure the new reminder was persisted.
      final updatedReminder =
          verify(
                () => reminderRepository.updateReminder(captureAny()),
              ).captured.single
              as ReminderEntity;

      expect(updatedReminder.id, 'reminder-1');
      expect(updatedReminder.title, 'New title');
      expect(updatedReminder.amount, 200);
      expect(updatedReminder.frequency, ContributionPeriod.daily);
      expect(updatedReminder.scheduleDate, newScheduleDate);
      expect(updatedReminder.deadline, newDeadline);

      // 3. Old notifications should be cancelled.
      final cancelledIds = verify(
        () => notificationService.cancelNotification(captureAny()),
      ).captured.cast<String>();

      expect(cancelledIds, [
        'reminder-1-2026-10-10T10:30:00.000',
        'reminder-1-2026-10-11T10:30:00.000',
        'reminder-1-2026-10-12T10:30:00.000',
      ]);

      // 4. New notifications should be scheduled.
      final scheduledRequests = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();

      expect(scheduledRequests.length, 3);

      expect(scheduledRequests.map((e) => e.scheduleDate).toList(), [
        DateTime(2026, 10, 15, 10, 30),
        DateTime(2026, 10, 16, 10, 30),
        DateTime(2026, 10, 17, 10, 30),
      ]);

      expect(
        scheduledRequests.every(
          (request) =>
              request.title == 'New title' &&
              request.recurrence == NotificationRecurrence.daily,
        ),
        true,
      );
    },
  );

  test(
    'should update reminder, cancel old notifications, and schedule a new notification',
    () async {
      // Arrange

      final oldReminder = ReminderEntity(
        id: 'reminder-1',
        title: 'Old title',
        amount: 100,
        frequency: ContributionPeriod.daily,
        scheduleDate: DateTime(2026, 10, 10, 10, 30),
        deadline: DateTime(2026, 10, 12, 10, 30),
      );

      final newScheduleDate = DateTime(2026, 10, 11, 10, 30);
      final newDeadline = DateTime(2026, 10, 17, 10, 30);

      when(
        () => reminderRepository.getReminderById('reminder-1'),
      ).thenAnswer((_) async => right(oldReminder));

      when(
        () => reminderRepository.updateReminder(any()),
      ).thenAnswer((_) async => right(null));

      // Act

      final result = await usecase(
        id: 'reminder-1',
        title: 'New title',
        amount: 200,
        frequency: ContributionPeriod.none,
        scheduleDate: newScheduleDate,
        deadline: newDeadline,
      );

      // Assert

      expect(result.isRight(), true);

      // 1. Make sure the old reminder was requested.
      verify(() => reminderRepository.getReminderById('reminder-1')).called(1);

      // 2. Make sure the new reminder was persisted.
      final updatedReminder =
          verify(
                () => reminderRepository.updateReminder(captureAny()),
              ).captured.single
              as ReminderEntity;

      expect(updatedReminder.id, 'reminder-1');
      expect(updatedReminder.title, 'New title');
      expect(updatedReminder.amount, 200);
      expect(updatedReminder.frequency, ContributionPeriod.none);
      expect(updatedReminder.scheduleDate, newScheduleDate);
      expect(updatedReminder.deadline, newDeadline);

      // 3. Old notifications should be cancelled.
      final cancelledIds = verify(
        () => notificationService.cancelNotification(captureAny()),
      ).captured.cast<String>();

      expect(cancelledIds, [
        'reminder-1-2026-10-10T10:30:00.000',
        'reminder-1-2026-10-11T10:30:00.000',
        'reminder-1-2026-10-12T10:30:00.000',
      ]);

      // 4. New notifications should be scheduled.
      final scheduledRequests = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();

      expect(scheduledRequests.length, 1);

      expect(scheduledRequests.map((e) => e.scheduleDate).toList(), [
        newDeadline,
      ]);

      expect(
        scheduledRequests.every(
          (request) =>
              request.title == 'New title' &&
              request.recurrence == NotificationRecurrence.none,
        ),
        true,
      );
    },
  );
  test(
    'should update reminder,won\'t cancel any old notifications, and schedule no new notification',
    () async {
      // Arrange

      final oldReminder = ReminderEntity(
        id: 'reminder-1',
        title: 'Old title',
        amount: 100,
        frequency: ContributionPeriod.daily,
        scheduleDate: DateTime(2026, 10, 10, 10, 30),
        deadline: DateTime(2026, 10, 12, 10, 30),
      );

      final newScheduleDate = DateTime(2026, 10, 11, 10, 30);
      final newDeadline = DateTime(2026, 10, 17, 10, 30);

      when(() => reminderRepository.getReminderById('reminder-1')).thenAnswer(
        (_) async => left(NotificationFailure('Reminder not found')),
      );

      when(
        () => reminderRepository.updateReminder(any()),
      ).thenAnswer((_) async => right(null));

      // Act

      final result = await usecase(
        id: 'reminder-1',
        title: 'New title',
        amount: 200,
        frequency: ContributionPeriod.none,
        scheduleDate: newScheduleDate,
        deadline: newDeadline,
      );

      // Assert

      expect(result.isRight(), false);

      // 1. Make sure the old reminder was requested.
      verify(() => reminderRepository.getReminderById('reminder-1')).called(1);

      verifyNever(() => reminderRepository.updateReminder(captureAny()));

      // 3. Old notifications should not be cancelled.
      verifyNever(() => notificationService.cancelNotification(captureAny()));

      // 4. New notifications should be scheduled.
      verifyNever(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();
    },
  );

  test(
    'should update reminder,won\'t cancel any old notifications, and schedule no new notifications',
    () async {
      // Arrange

      final oldReminder = ReminderEntity(
        id: 'reminder-1',
        title: 'Old title',
        amount: 100,
        frequency: ContributionPeriod.daily,
        scheduleDate: DateTime(2026, 10, 10, 10, 30),
        deadline: DateTime(2026, 10, 12, 10, 30),
      );

      final newScheduleDate = DateTime(2026, 10, 11, 10, 30);
      final newDeadline = DateTime(2026, 10, 17, 10, 30);

      when(
        () => reminderRepository.getReminderById('reminder-1'),
      ).thenAnswer((_) async => right(oldReminder));

      when(
        () => reminderRepository.updateReminder(any()),
      ).thenAnswer((_) async => Left(NotificationFailure('Failed to update')));

      // Act

      final result = await usecase(
        id: 'reminder-1',
        title: 'New title',
        amount: 200,
        frequency: ContributionPeriod.none,
        scheduleDate: newScheduleDate,
        deadline: newDeadline,
      );

      // Assert

      expect(result.isRight(), false);

      // 1. Make sure the old reminder was requested.
      verify(() => reminderRepository.getReminderById('reminder-1')).called(1);
      // 1. Make sure the old reminder was requested.
      verify(() => reminderRepository.updateReminder(captureAny())).called(1);

      // 3. Old notifications should not be cancelled.
      verifyNever(() => notificationService.cancelNotification(captureAny()));

      // 4. New notifications should be scheduled.
      verifyNever(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();
    },
  );

  test(
    'should return failure and cleanup already scheduled notifications when scheduling fails',
    () async {
      // Arrange

      final oldReminder = ReminderEntity(
        id: 'reminder-1',
        title: 'Old title',
        amount: 100,
        frequency: ContributionPeriod.daily,
        scheduleDate: DateTime(2026, 10, 10, 10, 30),
        deadline: DateTime(2026, 10, 12, 10, 30),
      );

      final newScheduleDate = DateTime(2026, 10, 15, 10, 30);
      final newDeadline = DateTime(2026, 10, 17, 10, 30);

      when(
        () => reminderRepository.getReminderById('reminder-1'),
      ).thenAnswer((_) async => right(oldReminder));

      when(
        () => reminderRepository.updateReminder(any()),
      ).thenAnswer((_) async => right(null));

      // Fail when scheduling the second notification.
      when(
        () => notificationService.scheduleNotification(
          any(
            that: isA<NotificationRequest>().having(
              (request) => request.scheduleDate,
              'scheduleDate',
              DateTime(2026, 10, 16, 10, 30),
            ),
          ),
        ),
      ).thenThrow(Exception('Failed to schedule notification'));

      // Act

      final result = await usecase(
        id: 'reminder-1',
        title: 'New title',
        amount: 200,
        frequency: ContributionPeriod.daily,
        scheduleDate: newScheduleDate,
        deadline: newDeadline,
      );

      // Assert

      expect(result.isLeft(), true);

      // Old reminder was retrieved.
      verify(() => reminderRepository.getReminderById('reminder-1')).called(1);

      // Reminder was updated.
      final updatedReminder =
          verify(
                () => reminderRepository.updateReminder(captureAny()),
              ).captured.single
              as ReminderEntity;

      expect(updatedReminder.id, 'reminder-1');
      expect(updatedReminder.title, 'New title');
      expect(updatedReminder.amount, 200);
      expect(updatedReminder.frequency, ContributionPeriod.daily);
      expect(updatedReminder.scheduleDate, newScheduleDate);
      expect(updatedReminder.deadline, newDeadline);

      // Old notifications were cancelled.
      final cancelledIds = verify(
        () => notificationService.cancelNotification(captureAny()),
      ).captured.cast<String>();

      expect(cancelledIds, [
        'reminder-1-2026-10-10T10:30:00.000',
        'reminder-1-2026-10-11T10:30:00.000',
        'reminder-1-2026-10-12T10:30:00.000',
        'reminder-1-2026-10-15T10:30:00.000',
      ]);

      // First new notification was scheduled successfully.
      final scheduledRequests = verify(
        () => notificationService.scheduleNotification(captureAny()),
      ).captured.cast<NotificationRequest>();

      expect(scheduledRequests.length, 2);

      expect(scheduledRequests[0].scheduleDate, DateTime(2026, 10, 15, 10, 30));

      expect(scheduledRequests[1].scheduleDate, DateTime(2026, 10, 16, 10, 30));

      // The already scheduled notification should be cleaned up.
      // The third notification was never successfully scheduled,
      // therefore it should not be part of cleanup.
      verifyNever(
        () => notificationService.cancelNotification(
          'reminder-1-2026-10-16T10:30:00.000',
        ),
      );
    },
  );
  ;
}
