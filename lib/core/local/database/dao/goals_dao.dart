import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/tables/goals_table.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
part 'goals_dao.g.dart';

@DriftAccessor(tables: [GoalsTable])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.db);

  Future<void> insertGoal(GoalsTableCompanion data) {
    return into(goalsTable).insert(data);
  }

  Future<bool> updateGoal(GoalsTableCompanion data) {
    return update(goalsTable).replace(data);
  }

  Future<int> deleteGoal(String id) {
    return (delete(goalsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<GoalsTableData?> getGoalById(String id) {
    return (select(
      goalsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<GoalsTableData>> watchGoals() => select(goalsTable).watch();

  Future<void> upsertGoal(GoalsTableCompanion data) {
    return into(goalsTable).insertOnConflictUpdate(data);
  }

  Future<void> updateGoalStatus(String id, GoalStatus status) {
    return (update(goalsTable)..where((tbl) => tbl.id.equals(id))).write(
      GoalsTableCompanion(
        status: Value(status),
      ),
    );
  }
}
