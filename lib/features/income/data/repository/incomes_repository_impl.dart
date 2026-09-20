import 'package:fpdart/src/either.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/income/data/models/income_model.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';
import 'package:uuid/uuid.dart';

class IncomesRepositoryImpl implements IncomesRepository {
  final IncomesLocalDataSource incomesLocalDataSource;
  IncomesRepositoryImpl(this.incomesLocalDataSource);

  @override
  Future<Either<Failure, void>> addIncome(IncomeEntity income) async {
    try {
      final uuid = Uuid();
      final IncomeModel incomeModel = IncomeModel.fromEntity(income);
      return Right(
        await incomesLocalDataSource.insertIncome(
          incomeModel,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: income.id,
            entityType: EntityType.income,
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
  Future<Either<Failure, void>> deleteIncome(String incomeId) async {
    try {
      final uuid = Uuid();
      return Right(
        await incomesLocalDataSource.deleteIncome(
          incomeId,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: incomeId,
            entityType: EntityType.income,
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
  Future<Either<Failure, IncomeEntity?>> getIncomeById(String id) async {
    try {
      return Right(
        (await incomesLocalDataSource.getIncomeById(id))!.toEntity(),
      );
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> updateIncome(IncomeEntity income) async {
    try {
      return Right(
        await incomesLocalDataSource.updateIncome(
          IncomeModel.fromEntity(income),
          PendingOperationModel(
            operationId: Uuid().v4(),
            entityId: income.id,
            entityType: EntityType.income,
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
  Stream<Either<Failure, List<IncomeEntity>>> watchIncomes() async* {
    try {
      await for (final data in incomesLocalDataSource.watchIncomes()) {
        yield Right(data.map((e) => e.toEntity()).toList());
      }
    } on Exception catch (e) {
      yield Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }
}
