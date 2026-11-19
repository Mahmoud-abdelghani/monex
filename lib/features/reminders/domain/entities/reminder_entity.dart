import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/domain/value_objects/reminder_amount.dart';
import 'package:monex/features/reminders/domain/value_objects/reminder_deadline.dart';
import 'package:monex/features/reminders/domain/value_objects/reminder_schedule_date.dart';
import 'package:monex/features/reminders/domain/value_objects/reminder_title.dart';

class ReminderEntity {
  final String id;
  final ReminderTitle title;
  final ReminderAmount amount;
  final ContributionPeriod frequency;
  final ReminderScheduleDate scheduleDate;
  final ReminderDeadline deadline;

  ReminderEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.deadline,
    required this.scheduleDate,
  }) {
    if ((deadline.value).isBefore(scheduleDate.value)) {
      throw ArgumentError('Reminder deadline cannot be before schedule date');
    }
  }
}
