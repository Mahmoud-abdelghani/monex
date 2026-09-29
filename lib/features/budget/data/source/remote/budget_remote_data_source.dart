
import 'package:monex/features/budget/data/model/budget_model.dart';

abstract class BudgetRemoteDataSource {
  Future<void> createBudget(BudgetModel data);
  Future<void> updateBudget(BudgetModel data);
  Future<BudgetModel?> getCurrentBudget(String userId);
}
