import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> insertExpense(
    ExpenseModel expense,
    PendingOperationModel pendingOperation,
  );
  Future<bool> updateExpense(
    ExpenseModel expense,
    PendingOperationModel pendingOperation,
  );
  Future<ExpenseModel?> getExpenseById(
    String id,
  
  );
  Future<void> deleteExpense(String id, PendingOperationModel pendingOperation);
  Stream<List<ExpenseModel>> watchExpenses();
 

Future<void> syncRemoteExpenses(
  List<ExpenseModel> expenses,
);
}
