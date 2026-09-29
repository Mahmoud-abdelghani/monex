import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';

class GoalModel {
  final String id;
  final String title;
  final double targetAmount;
  final DateTime deadline;
  final GoalStatus status;
  final ContributionPeriod contributionPeriod;

  GoalModel({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.deadline,
    required this.status,
    required this.contributionPeriod,
  });

  GoalEntity toEntity() => GoalEntity(
    id: id,
    title: title,
    targetAmount: targetAmount,
    deadline: deadline,
    status: status,
    contributionPeriod: contributionPeriod,
  );

  factory GoalModel.fromEntity(GoalEntity entity) => GoalModel(
    id: entity.id,
    title: entity.title,
    targetAmount: entity.targetAmount,
    deadline: entity.deadline,
    status: entity.status,
    contributionPeriod: entity.contributionPeriod,
  );

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'] as String,
    title: json['title'] as String,
    targetAmount: json['target_amount'] as double,
    deadline: DateTime.parse(json['deadline'] as String),
    status: GoalStatus.values[json['status'] as int],
    contributionPeriod:
        ContributionPeriod.values[json['contribution_period'] as int],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'target_amount': targetAmount,
    'deadline': deadline.toUtc().toIso8601String(),
    'status': status.index,
    'contribution_period': contributionPeriod.index,
  };
}
