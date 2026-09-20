import 'package:monex/features/expense/data/models/expense_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseModel>> getExpenses();
  Future<void> addExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<ExpenseModel?> getExpenseById(String id);
  Future<void> deleteExpense(String expenseId);
  Future<void> processExpenseInsert({
  required String operationId,
  required ExpenseModel expense,
});


}
