// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_dao.dart';

// ignore_for_file: type=lint
mixin _$RemindersDaoMixin on DatabaseAccessor<AppDatabase> {
  $RemindersTableTable get remindersTable => attachedDatabase.remindersTable;
  RemindersDaoManager get managers => RemindersDaoManager(this);
}

class RemindersDaoManager {
  final _$RemindersDaoMixin _db;
  RemindersDaoManager(this._db);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(
        _db.attachedDatabase,
        _db.remindersTable,
      );
}
