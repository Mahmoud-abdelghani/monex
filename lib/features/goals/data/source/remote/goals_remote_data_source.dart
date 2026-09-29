import 'package:monex/features/goals/data/models/goal_model.dart';

abstract class GoalsRemoteDataSource {
  Future<void> insertGoal(GoalModel goal, String operationId);
  Future<void> updateGoal(GoalModel goal);
  Future<GoalModel?> getGoalById(String goalId);
  Future<void> deleteGoal(String goalId);
  Future<List<GoalModel>> getGoals();
  Future<void> completeGoal(String goalId);
}
