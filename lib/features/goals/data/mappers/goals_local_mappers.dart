import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/goals/data/models/goal_model.dart';

extension GoalsLocalMappers on GoalModel {
  GoalsTableCompanion toGoalsTableCompanion() {
    return GoalsTableCompanion(
      id: Value(id),
      title: Value(title),
      targetAmount: Value(targetAmount),
      deadline: Value(deadline),
      status: Value(status),
      contributionPeriod: Value(contributionPeriod),
    );
  }
}

extension GoalsTableDataMapper on GoalsTableData {
  
  GoalModel toGoalModel() {
    return GoalModel(
      id: id,
      title: title,
      targetAmount: targetAmount,
      deadline: deadline,
      status: status,
      contributionPeriod: contributionPeriod,
    );
  }
}
