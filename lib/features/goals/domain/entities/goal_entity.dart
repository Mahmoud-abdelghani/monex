import 'package:monex/core/enums/contribution_period.dart';

class GoalEntity {
  final String id;
  final String title;
  final double targetAmount;
  final DateTime deadline;
  final GoalStatus status;
  final ContributionPeriod contributionPeriod;

  GoalEntity({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.deadline,
    required this.status,
    required this.contributionPeriod,
  });
}

enum GoalStatus {
  active,
  completed,
  cancelled,
}
