import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';

class UpdateExpenseUseCase {
  final ExpenseRepository expenseRepository;
  UpdateExpenseUseCase(this.expenseRepository);

  Future<Either<Failure, void>> call({required ExpenseEntity expense}) {
    return expenseRepository.updateExpense(expense: expense);
  }
}