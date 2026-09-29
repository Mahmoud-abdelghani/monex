import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/budget/data/source/local/budget_local_data_source.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource budgetLocalDataSource;

  BudgetRepositoryImpl(this.budgetLocalDataSource);

  @override
  Future<Either<Failure, void>> createBudget(BudgetEntity budget) async {
    try {
      return right(
        await budgetLocalDataSource.createBudget(
          BudgetModel.fromEntity(budget),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: budget.id,
            entityType: EntityType.budget,
            operation: Operation.insert,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, BudgetEntity?>> getCurrentBudget() async {
    try {
      return right(
        (await budgetLocalDataSource.getCurrentBudget())?.toEntity(),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> updateBudget(BudgetEntity budget) async {
    try {
      return right(
        await budgetLocalDataSource.updateBudget(
          BudgetModel.fromEntity(budget),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: budget.id,
            entityType: EntityType.budget,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Stream<Either<Failure, BudgetEntity?>> watchBudget() async* {
    try {
      await for (final data in budgetLocalDataSource.watchBudget()) {
        yield right(data?.toEntity());
      }
    } on Exception catch (e) {
      yield left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }
}
