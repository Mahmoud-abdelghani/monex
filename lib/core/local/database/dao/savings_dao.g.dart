// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_dao.dart';

// ignore_for_file: type=lint
mixin _$SavingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SavingsTableTable get savingsTable => attachedDatabase.savingsTable;
  SavingsDaoManager get managers => SavingsDaoManager(this);
}

class SavingsDaoManager {
  final _$SavingsDaoMixin _db;
  SavingsDaoManager(this._db);
  $$SavingsTableTableTableManager get savingsTable =>
      $$SavingsTableTableTableManager(_db.attachedDatabase, _db.savingsTable);
}
