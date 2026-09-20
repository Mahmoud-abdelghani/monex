import 'package:drift/drift.dart';

class IncomesCategoriesTable extends Table{
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();

  @override
  Set<Column> get primaryKey => {id};
}