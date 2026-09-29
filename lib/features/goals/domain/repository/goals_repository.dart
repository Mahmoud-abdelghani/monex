import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';

abstract class GoalsRepository {
  Future<Either<Failure, void>> addGoal(GoalEntity goal);
  Future<Either<Failure, void>> updateGoal(GoalEntity goal);
  Future<Either<Failure, void>> deleteGoal(String goalId);
  Future<Either<Failure, GoalEntity?>> getGoalById(String goalId);
  Stream<Either<Failure, List<GoalEntity>>> watchGoals();
  Future<Either<Failure, void>> completeGoal(String goalId);
}
