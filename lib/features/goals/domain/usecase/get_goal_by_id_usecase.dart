import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';

class GetGoalByIdUsecase {
  final GoalsRepository repository;

  GetGoalByIdUsecase(this.repository);

  Future<Either<Failure, GoalEntity?>> call(String goalId) => repository.getGoalById(goalId);
}