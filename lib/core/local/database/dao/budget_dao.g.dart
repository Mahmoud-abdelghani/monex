// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_dao.dart';

// ignore_for_file: type=lint
mixin _$BudgetDaoMixin on DatabaseAccessor<AppDatabase> {
  $BudgetTableTable get budgetTable => attachedDatabase.budgetTable;
  BudgetDaoManager get managers => BudgetDaoManager(this);
}

class BudgetDaoManager {
  final _$BudgetDaoMixin _db;
  BudgetDaoManager(this._db);
  $$BudgetTableTableTableManager get budgetTable =>
      $$BudgetTableTableTableManager(_db.attachedDatabase, _db.budgetTable);
}
