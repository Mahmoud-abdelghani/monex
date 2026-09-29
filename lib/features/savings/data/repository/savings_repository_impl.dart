import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/savings/data/models/saving_model.dart';
import 'package:monex/features/savings/data/source/local/savings_local_data_source.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class SavingsRepositoryImpl implements SavingsRepository {
  final SavingsLocalDataSource savingsLocalDataSource;
  SavingsRepositoryImpl(this.savingsLocalDataSource);

  @override
  Future<Either<Failure, void>> addSaving(SavingEntity saving) async {
    try {
      return Right(
        await savingsLocalDataSource.insertSaving(
          SavingModel.fromEntity(saving),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: saving.id,
            entityType: EntityType.saving,
            operation: Operation.insert,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSaving(String savingId) async {
    try {
      return Right(
        await savingsLocalDataSource.deleteSaving(
          savingId,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: savingId,
            entityType: EntityType.saving,
            operation: Operation.delete,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SavingEntity?>> getSavingById(String savingId) async {
    try {
      final saving = await savingsLocalDataSource.getSavingById(savingId);

      return Right(saving?.toEntity());
    } on Exception catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSaving(SavingEntity saving) async {
    try {
      return Right(
        await savingsLocalDataSource.updateSaving(
          SavingModel.fromEntity(saving),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: saving.id,
            entityType: EntityType.saving,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<SavingEntity>>> watchSavings() async* {
    try {
      await for (final data in savingsLocalDataSource.watchSavings()) {
        yield Right(data.map((e) => e.toEntity()).toList());
      }
    } on Exception catch (e) {
      yield Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SavingEntity>>> getSavingsByGoalId(
    String goalId,
  ) async {
    try {
      return Right(
        (await savingsLocalDataSource.getSavingsByGoalId(
          goalId,
        )).map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }
}
