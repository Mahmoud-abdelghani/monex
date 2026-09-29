import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';
import 'package:uuid/uuid.dart';

class AddGoalUsecase {
  final GoalsRepository repository;

  AddGoalUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String title,
    required double targetAmount,
    required DateTime deadline,
    required GoalStatus status,
    required ContributionPeriod contributionPeriod,
  }) => repository.addGoal(
    GoalEntity(
      title: title,
      targetAmount: targetAmount,
      deadline: deadline,
      status: status,
      contributionPeriod: contributionPeriod,
      id: uuid.v4(),
    ),
  );
}
