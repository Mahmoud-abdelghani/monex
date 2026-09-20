import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository expenseRepository;
  DeleteExpenseUseCase(this.expenseRepository);

  Future<Either<Failure, void>> call(String expenseId) async {
    return await expenseRepository.deleteExpense(expenseId: expenseId);
  }
}
