import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, void>> addExpense({required ExpenseEntity expense});
  Future<Either<Failure, void>> updateExpense({required ExpenseEntity expense});
  Future<Either<Failure, void>> deleteExpense({required String expenseId});
  Future<Either<Failure, ExpenseEntity?>> getExpenseById({required String id});
  Stream<Either<Failure, List<ExpenseEntity>>> watchExpenses();
}
