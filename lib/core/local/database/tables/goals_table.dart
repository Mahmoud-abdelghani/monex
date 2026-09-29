import 'package:drift/drift.dart';
import 'package:monex/core/local/database/converters/goals_enum_converter.dart';

class GoalsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get targetAmount => real()();
  DateTimeColumn get deadline => dateTime()();
  IntColumn get status => integer().map(const GoalStatusConverter())();
  IntColumn get contributionPeriod =>
      integer().map(const ContributionPeriodConverter())();

  @override
  Set<Column> get primaryKey => {id};
}
