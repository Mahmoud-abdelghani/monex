// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incomes_dao.dart';

// ignore_for_file: type=lint
mixin _$IncomesDaoMixin on DatabaseAccessor<AppDatabase> {
  $IncomesTableTable get incomesTable => attachedDatabase.incomesTable;
  IncomesDaoManager get managers => IncomesDaoManager(this);
}

class IncomesDaoManager {
  final _$IncomesDaoMixin _db;
  IncomesDaoManager(this._db);
  $$IncomesTableTableTableManager get incomesTable =>
      $$IncomesTableTableTableManager(_db.attachedDatabase, _db.incomesTable);
}
