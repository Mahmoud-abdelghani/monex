import 'package:fpdart/fpdart.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/helpers/notification_reminder_helper.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/mappers/reminder_notification_mapper.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class UpdateReminderUsecase {
  final ReminderRepository reminderRepository;
  final NotificationService notificationService;
  final NotificationScheduleCalculator notificationScheduleCalculator;

  UpdateReminderUsecase({
    required this.reminderRepository,
    required this.notificationService,
    required this.notificationScheduleCalculator,
  });

  Future<Either<Failure, void>> call({
    required String id,
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
    required DateTime scheduleDate,
  }) async {
    final reminderEntity = ReminderEntity(
      id: id,
      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
      scheduleDate: scheduleDate,
    );

    final oldReminderResult = await reminderRepository.getReminderById(id);

    if (oldReminderResult.isLeft()) {
      return oldReminderResult;
    }

    final oldReminder = oldReminderResult.getRight().toNullable();

    if (oldReminder == null) {
      return Left(NotificationFailure('Reminder not found'));
    }

    final oldScheduleIds = NotificationReminderHelper.getScheduleIds(oldReminder, notificationScheduleCalculator);

    final updateResult = await reminderRepository.updateReminder(
      reminderEntity,
    );

    if (updateResult.isLeft()) {
      return updateResult;
    }

    for (final notificationId in oldScheduleIds) {
      await notificationService.cancelNotification(notificationId);
    }

    final scheduledNotificationIds = <String>[];

    try {
      final newSchedules = notificationScheduleCalculator.calculateSchedules(
        NotificationRequest(
          id: reminderEntity.id,
          title: reminderEntity.title,
          body:
              'Reminder for ${reminderEntity.title} amount ${reminderEntity.amount}',
          scheduleDate: reminderEntity.scheduleDate,
          recurrence: reminderEntity.frequency.toNotificationRecurrence(),
          endDate: reminderEntity.deadline,
        ),
      );

      for (final schedule in newSchedules) {
        final notificationId =
            '${reminderEntity.id}-${schedule.toIso8601String()}';

        final notificationRequest = NotificationRequest(
          id: notificationId,
          title: reminderEntity.title,
          body:
              'Reminder for ${reminderEntity.title} amount ${reminderEntity.amount}',
          scheduleDate: schedule,
          recurrence: reminderEntity.frequency.toNotificationRecurrence(),
          endDate: reminderEntity.deadline,
        );

        await notificationService.scheduleNotification(notificationRequest);

        scheduledNotificationIds.add(notificationId);
      }
    } on Exception catch (e) {
      for (final notificationId in scheduledNotificationIds) {
        try {
          await notificationService.cancelNotification(notificationId);
        } on Exception {
          // Best effort cleanup.
        }
      }

      return Left(NotificationFailure(extractErrorMessage(e)));
    }

    return const Right(null);
  }

 
}
