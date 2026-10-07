import 'package:drift/drift.dart';
import 'package:monex/core/local/database/converters/goals_enum_converter.dart';

class RemindersTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  IntColumn get frequency =>
      integer().map(const ContributionPeriodConverter())();
  DateTimeColumn get deadline => dateTime()();
  DateTimeColumn get scheduleDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
