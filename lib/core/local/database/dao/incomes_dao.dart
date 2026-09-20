import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/incomes_table.dart';
part 'incomes_dao.g.dart';

@DriftAccessor(tables: [IncomesTable])
class IncomesDao extends DatabaseAccessor<AppDatabase> with _$IncomesDaoMixin {
  IncomesDao(super.db);

  Future<void> insertIncome(IncomesTableCompanion data) {
    return into(incomesTable).insert(data);
  }

  Future<bool> updateIncome(IncomesTableCompanion data) {
    return update(incomesTable).replace(data);
  }

  Future<int> deleteIncome(String id) {
    return (delete(incomesTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<IncomesTableData?> getIncomeById(String id) {
    return (select(
      incomesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<IncomesTableData>> watchIncomes() {
    return select(incomesTable).watch();
    
  }

  Future<void> upsertIncome(IncomesTableCompanion data) {
    return into(incomesTable).insertOnConflictUpdate(data);
  }
}
