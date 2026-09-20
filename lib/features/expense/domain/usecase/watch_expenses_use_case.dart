import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';

class WatchExpensesUseCase {
  final ExpenseRepository expenseRepository;
  WatchExpensesUseCase(this.expenseRepository);

  Stream <Either<Failure, List<ExpenseEntity>>> call() {
    return expenseRepository.watchExpenses();
  }
}
