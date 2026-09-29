import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';

abstract class BudgetLocalDataSource {
  Future<void> createBudget(BudgetModel data,PendingOperationModel pendingOperationModel);
  Future<void> updateBudget(BudgetModel data,PendingOperationModel pendingOperationModel);
  Future<BudgetModel?> getCurrentBudget();
  Stream<BudgetModel?> watchBudget();
  Future<void> syncRemoteBudget(BudgetModel data);
}