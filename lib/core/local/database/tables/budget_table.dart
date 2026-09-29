import 'package:drift/drift.dart';

class BudgetTable extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();

  @override
  Set<Column> get primaryKey => {id};
}
