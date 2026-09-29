import 'package:drift/drift.dart';

class SavingsTable extends Table {
  TextColumn get id => text()();
  TextColumn get goalId => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
