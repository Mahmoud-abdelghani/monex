import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';

class WatchGoalsUsecase {
  final GoalsRepository repository;
  WatchGoalsUsecase( this.repository);

  Stream<Either<Failure, List<GoalEntity>>> call() => repository.watchGoals();
}
