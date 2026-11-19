import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/helpers/notification_reminder_helper.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/mappers/reminder_notification_mapper.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class ReschduleReminderUsecase {
  final ReminderRepository reminderRepository;
  final NotificationScheduleCalculator notificationScheduleCalculator;
  final NotificationService notificationService;
  ReschduleReminderUsecase({
    required this.reminderRepository,
    required this.notificationScheduleCalculator,
    required this.notificationService,
  });

  Future<Either<Failure, void>> call(String reminderId) async {
    final result = await reminderRepository.getReminderById(reminderId);
    if (result.isLeft()) {
      return result;
    }

    final reminder = result.getRight().toNullable();

    if (reminder == null) {
      return Left(NotificationFailure('Reminder not found'));
    }

    try {
      final scheduleIds = NotificationReminderHelper.getScheduleIds(
        reminder,
        notificationScheduleCalculator,
      );

      for (final scheduleId in scheduleIds) {
        await notificationService.cancelNotification(scheduleId);
      }

      final schedules = notificationScheduleCalculator.calculateSchedules(
        NotificationRequest(
          id: reminder.id,
          title: reminder.title.value,
          body:
              'Reminder for ${reminder.title} amount ${reminder.amount} on ${reminder.deadline}',
          scheduleDate: reminder.scheduleDate.value,
          recurrence: reminder.frequency.toNotificationRecurrence(),
          endDate: reminder.deadline.value,
        ),
      );

      for (final schedule in schedules) {
        if (schedule.isBefore(DateTime.now())) continue;
        await notificationService.scheduleNotification(
          NotificationRequest(
            id: '${reminder.id}-${schedule.toIso8601String()}',
            title: reminder.title.value,
            body:
                'Reminder for ${reminder.title} amount ${reminder.amount} on ${reminder.deadline}',
            scheduleDate: schedule,
            recurrence: reminder.frequency.toNotificationRecurrence(),
            endDate: reminder.deadline.value,
          ),
        );
      }
    } on Exception catch (e) {
      return Left(NotificationFailure(e.toString()));
    }

    return Right(null);
  }
}
