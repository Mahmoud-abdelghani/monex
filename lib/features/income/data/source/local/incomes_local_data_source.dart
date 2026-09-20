import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/income/data/models/income_model.dart';

abstract class IncomesLocalDataSource {
  Future<void> insertIncome(IncomeModel data, PendingOperationModel pendingOperation);
  Future<void> updateIncome(IncomeModel data, PendingOperationModel pendingOperation);
  Future<void> deleteIncome(String id, PendingOperationModel pendingOperation);
  Future<IncomeModel?> getIncomeById(String id);
  Stream<List<IncomeModel>> watchIncomes();
  Future<void> syncRemoteIncomes(List<IncomeModel> incomes); 
}
