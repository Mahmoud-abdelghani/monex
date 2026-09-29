import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';

class CompleteGoalUsecase {
  final GoalsRepository repository;

  CompleteGoalUsecase(this.repository);

  Future<Either<Failure, void>> call(String goalId) =>
      repository.completeGoal(goalId);
}
