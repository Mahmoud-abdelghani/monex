import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/helpers/notification_reminder_helper.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/mappers/reminder_notification_mapper.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class DeleteReminderUsecase {
  final ReminderRepository reminderRepository;
  final NotificationService notificationService;
  final NotificationScheduleCalculator notificationScheduleCalculator;

  DeleteReminderUsecase({
    required this.reminderRepository,
    required this.notificationService,
    required this.notificationScheduleCalculator,
  });

  Future<Either<Failure, void>> call(String id) async {
    final result = await reminderRepository.getReminderById(id);
    if (result.isLeft()) {
      return result;
    }

    final reminder = result.getRight().toNullable();

    if (reminder == null) {
      return Left(NotificationFailure('Reminder not found'));
    }
    List<String> scheduleIds = [];
    List<String> cancelledScheduleIds = [];
    try {
      scheduleIds = NotificationReminderHelper.getScheduleIds(
        reminder,
        notificationScheduleCalculator,
      );
      for (final scheduleId in scheduleIds) {
        await notificationService.cancelNotification(scheduleId);
        cancelledScheduleIds.add(scheduleId);
      }
    } on Exception catch (e) {
      try {
        for (final scheduleId in cancelledScheduleIds) {
          await notificationService.scheduleNotification(
            NotificationRequest(
              id: scheduleId,
              title: reminder.title,
              body: 'Reminder for ${reminder.title} amount ${reminder.amount}',
              scheduleDate: reminder.scheduleDate,
              recurrence: reminder.frequency.toNotificationRecurrence(),
              endDate: reminder.deadline,
            ),
          );
        }
      } on Exception catch (e) {
        // Best effort
      }
      return Left(NotificationFailure(extractErrorMessage(e)));
    }

    final deleteResult = await reminderRepository.deleteReminder(id);

    if (deleteResult.isLeft()) {
      for (final scheduleId in scheduleIds) {
        await notificationService.scheduleNotification(
          NotificationRequest(
            id: scheduleId,
            title: reminder.title,
            body: 'Reminder for ${reminder.title} amount ${reminder.amount}',
            scheduleDate: reminder.scheduleDate,
            recurrence: reminder.frequency.toNotificationRecurrence(),
            endDate: reminder.deadline,
          ),
        );
      }
      return deleteResult;
    }

    return deleteResult;
  }
}
