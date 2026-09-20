import 'package:fpdart/src/either.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/error/failures/validation_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';
import 'package:uuid/uuid.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource expenseLocalDataSource;
  final ExpenseRemoteDataSource expenseRemoteDataSource;

  ExpenseRepositoryImpl(
    this.expenseLocalDataSource,
    this.expenseRemoteDataSource,
  );

  @override
  Future<Either<Failure, void>> addExpense({
    required ExpenseEntity expense,
  }) async {
    try {
      final uuid = Uuid();
      final ExpenseModel expenseModel = ExpenseModel.fromEntity(expense);
      await expenseLocalDataSource.insertExpense(
        expenseModel,
        PendingOperationModel(
          operationId: uuid.v4(),
          entityId: expense.id,
          entityType: EntityType.expense,
          operation: Operation.insert,
          status: OperationStatus.pending,
          retryCount: 0,
          lastAttemptedAt: null,
          createdAt: DateTime.now(),
        ),
      );

      return const Right(null);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense({
    required String expenseId,
  }) async {
    try {
      final uuid = Uuid().v4();
      await expenseLocalDataSource.deleteExpense(
        expenseId,
        PendingOperationModel(
          operationId: uuid,
          entityId: expenseId,
          entityType: EntityType.expense,
          operation: Operation.delete,
          status: OperationStatus.pending,
          retryCount: 0,
          lastAttemptedAt: null,
          createdAt: DateTime.now(),
        ),
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity?>> getExpenseById({required String id}) {
    // TODO: implement getExpenseById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateExpense({
    required ExpenseEntity expense,
  }) async {
    try {
      final uuid = Uuid().v4();
      final expenseModel = ExpenseModel.fromEntity(expense);
      await expenseLocalDataSource.updateExpense(
        expenseModel,
        PendingOperationModel(
          operationId: uuid,
          entityId: expense.id,
          entityType: EntityType.expense,
          operation: Operation.update,
          status: OperationStatus.pending,
          retryCount: 0,
          lastAttemptedAt: null,
          createdAt: DateTime.now(),
        ),
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }

  @override
  Stream<Either<Failure, List<ExpenseEntity>>> watchExpenses() async* {
    try {
      await for (final data in expenseLocalDataSource.watchExpenses()) {
        yield Right(data.map((e) => e.toEntity()).toList());
      }
    } on Exception catch (e) {
      yield Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }
}
