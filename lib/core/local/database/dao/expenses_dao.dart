import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/expenses_table.dart';

part 'expenses_dao.g.dart';

@DriftAccessor(tables: [ExpensesTable])
class ExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  Future<void> insertExpense(ExpensesTableCompanion expense) {
    return into(expensesTable).insert(expense);
  }

  Future<bool> updateExpense(ExpensesTableCompanion expense) {
    return update(expensesTable).replace(expense);
  }

  Future<int> deleteExpense(String id) {
    return (delete(expensesTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<ExpensesTableData?> getExpenseById(String id) {
    return (select(
      expensesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<ExpensesTableData>> watchExpenses() {
    return select(expensesTable).watch();
  }

  Future<void> upsertExpense(ExpensesTableCompanion expense) {
    return into(expensesTable).insertOnConflictUpdate(expense);
  }
}
