import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/goals/data/models/goal_model.dart';

abstract class GoalsLocalDataSource {
  Future<void> insertGoal(GoalModel goalModel,PendingOperationModel pendingOperationModel);
  Future<void> updateGoal(GoalModel goalModel,PendingOperationModel pendingOperationModel);
  Future<void> deleteGoal(String goalId,PendingOperationModel pendingOperationModel);
  Future<void> completeGoal(String goalId,PendingOperationModel pendingOperationModel);
  Future<GoalModel?> getGoalById(String goalId);
  Stream<List<GoalModel>> watchGoals();
  Future<void> syncRemoteGoals(List<GoalModel> goals);

}