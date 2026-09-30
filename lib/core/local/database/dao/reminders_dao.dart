import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/reminders_table.dart';

part 'reminders_dao.g.dart';

@DriftAccessor(tables: [RemindersTable])
class RemindersDao extends DatabaseAccessor<AppDatabase>
    with _$RemindersDaoMixin {
  RemindersDao(super.db);

  Future<void> insertReminder(RemindersTableCompanion data) {
    return into(remindersTable).insert(data);
  }

  Future<bool> updateReminder(RemindersTableCompanion data) {
    return update(remindersTable).replace(data);
  }

  Future<void> deleteReminder(String id) {
    return (delete(remindersTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<RemindersTableData?> getReminderById(String id) {
    return (select(
      remindersTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<RemindersTableData>> watchReminders() {
    return (select(remindersTable)).watch();
  }

  Future<void> upsertReminder(RemindersTableCompanion data) {
    return into(remindersTable).insertOnConflictUpdate(data);
  }
}
