import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/goals/data/models/goal_model.dart';
import 'package:monex/features/goals/data/source/local/goals_local_data_source.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsLocalDataSource goalsLocalDataSource;

  GoalsRepositoryImpl(this.goalsLocalDataSource);

  @override
  Future<Either<Failure, void>> addGoal(GoalEntity goal) async {
    try {
      return Right(
        await goalsLocalDataSource.insertGoal(
          GoalModel.fromEntity(goal),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: goal.id,
            entityType: EntityType.goal,
            operation: Operation.insert,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> completeGoal(String goalId) async {
    try {
      return Right(
        await goalsLocalDataSource.completeGoal(
          goalId,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: goalId,
            entityType: EntityType.goal,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGoal(String goalId) async {
    try {
      return Right(
        await goalsLocalDataSource.deleteGoal(
          goalId,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: goalId,
            entityType: EntityType.goal,
            operation: Operation.delete,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, GoalEntity?>> getGoalById(String goalId) async {
    try {
      return Right(
        (await goalsLocalDataSource.getGoalById(goalId))!.toEntity(),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> updateGoal(GoalEntity goal) async {
    try {
      return Right(
        await goalsLocalDataSource.updateGoal(
          GoalModel.fromEntity(goal),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: goal.id,
            entityType: EntityType.goal,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Stream<Either<Failure, List<GoalEntity>>> watchGoals() async* {
    try {
      await for (final data in goalsLocalDataSource.watchGoals()) {
        yield Right(data.map((e) => e.toEntity()).toList());
      }
    } on Exception catch (e) {
      yield Left(LocalStorageFailure(e.toString()));
    }
  }
}
