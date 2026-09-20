import 'package:drift/drift.dart';

class IncomesTable extends Table{
TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get categoryId => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get method => text()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}