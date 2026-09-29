import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';

class DeleteGoalUsecase {
  final GoalsRepository repository;
  DeleteGoalUsecase(this.repository);
  Future<Either<Failure, void>> call(String goalId) => repository.deleteGoal(goalId);
}