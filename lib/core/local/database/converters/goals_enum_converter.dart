import 'package:drift/drift.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';

class ContributionPeriodConverter extends TypeConverter<ContributionPeriod, int> {
  const ContributionPeriodConverter();

  @override
  ContributionPeriod fromSql(int fromDb) {
    return ContributionPeriod.values[fromDb];
  }

  @override
  int toSql(ContributionPeriod value) {
    return value.index;
  }
}

class GoalStatusConverter extends TypeConverter<GoalStatus, int> {
  const GoalStatusConverter();

  @override
  GoalStatus fromSql(int fromDb) {
    return GoalStatus.values[fromDb];
  }

  @override
  int toSql(GoalStatus value) {
    return value.index;
  }
}