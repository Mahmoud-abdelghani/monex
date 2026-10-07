import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/mappers/reminder_notification_mapper.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';

class NotificationReminderHelper {
  static List<String> getScheduleIds(
    ReminderEntity reminder,
    NotificationScheduleCalculator notificationScheduleCalculator,
  ) {
    final notificationRequest = NotificationRequest(
      id: reminder.id,
      title: reminder.title,
      body: 'Reminder for ${reminder.title} amount ${reminder.amount}',
      scheduleDate: reminder.scheduleDate,
      recurrence: reminder.frequency.toNotificationRecurrence(),
      endDate: reminder.deadline,
    );

    final schedules = notificationScheduleCalculator.calculateSchedules(
      notificationRequest,
    );

    return schedules
        .map((schedule) => '${reminder.id}-${schedule.toIso8601String()}')
        .toList();
  }
}
