import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';

class ReminderModel {
  final String id;
  final String title;
  final double amount;
  final ContributionPeriod frequency;
  final DateTime deadline;

  ReminderModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.deadline,
  });

  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
    id: entity.id,
    title: entity.title,
    amount: entity.amount,
    frequency: entity.frequency,
    deadline: entity.deadline,
  );

  ReminderEntity toEntity() => ReminderEntity(
    id: id,
    title: title,
    amount: amount,
    frequency: frequency,
    deadline: deadline,
  );

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'] as String,
    title: json['title'] as String,
    amount: json['amount'] as double,
    frequency: ContributionPeriod.values[json['frequency'] as int],
    deadline: DateTime.parse(json['deadline'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'frequency': frequency.index,
    'deadline': deadline.toIso8601String(),
  };
}
