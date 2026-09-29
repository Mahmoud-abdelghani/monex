import 'package:monex/core/enums/contribution_period.dart';

class RemainderEntity {
  final String id;
  final String title;
  final double amount;
  final ContributionPeriod frequency;
  final DateTime deadline;

  RemainderEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.deadline,
  });
}
