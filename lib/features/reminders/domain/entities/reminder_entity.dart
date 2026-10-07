import 'package:monex/core/enums/contribution_period.dart';

class ReminderEntity {
  final String id;
  final String title;
  final double amount;
  final ContributionPeriod frequency;
  final DateTime scheduleDate;
  final DateTime deadline;

  ReminderEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.deadline, required this.scheduleDate,
  });
}
