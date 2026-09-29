import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/savings_table.dart';
part 'savings_dao.g.dart';

@DriftAccessor(tables: [SavingsTable])
class SavingsDao extends DatabaseAccessor<AppDatabase> with _$SavingsDaoMixin {
  SavingsDao(super.db);

  Future<void> insertSaving(SavingsTableCompanion data) {
    return into(savingsTable).insert(data);
  }

  Future<bool> updateSaving(SavingsTableCompanion data) {
    return update(savingsTable).replace(data);
  }

  Future<int> deleteSaving(String id) {
    return (delete(savingsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<SavingsTableData?> getSavingById(String id) {
    return (select(
      savingsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<SavingsTableData>> watchSavings() => select(savingsTable).watch();

  Future<void> upsertSaving(SavingsTableCompanion data) {
    return into(savingsTable).insertOnConflictUpdate(data);
  }

  Future<List<SavingsTableData>> getSavingsByGoalId(String goalId) {
    return (select(savingsTable)..where((tbl) => tbl.goalId.equals(goalId)))
        .get();
  }
}
