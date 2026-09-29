import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/budget_table.dart';

part 'budget_dao.g.dart';

@DriftAccessor(tables: [BudgetTable])
class BudgetDao extends DatabaseAccessor<AppDatabase> with _$BudgetDaoMixin {
  BudgetDao(super.db);

  Future<BudgetTableData?> getCurrentBudget() =>
      select(budgetTable).getSingleOrNull();
  Stream<BudgetTableData?> watchBudget() => select(budgetTable).watchSingle();
  Future<void> insertBudget(BudgetTableCompanion data) =>
      into(budgetTable).insert(data);
  Future<void> updateBudget(BudgetTableCompanion data) =>
      update(budgetTable).replace(data);

  Future<void> upsertBudget(BudgetTableCompanion data) =>
      into(budgetTable).insertOnConflictUpdate(data);
}
