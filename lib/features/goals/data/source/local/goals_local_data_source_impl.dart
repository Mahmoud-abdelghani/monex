import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/budget_dao.dart';
import 'package:monex/core/local/database/dao/goals_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/dao/savings_dao.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/mapper/budget_mapper.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/goals/data/mappers/goals_local_mappers.dart';
import 'package:monex/features/goals/data/models/goal_model.dart';
import 'package:monex/features/goals/data/source/local/goals_local_data_source.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';

class GoalsLocalDataSourceImpl implements GoalsLocalDataSource {
  final GoalsDao goalsDao;
  final AppDatabase appDatabase;
  final PendingOperationsDao pendingOperationsDao;
  final SavingsDao savingsDao;
  final BudgetDao budgetDao;

  GoalsLocalDataSourceImpl({
    required this.goalsDao,
    required this.appDatabase,
    required this.pendingOperationsDao,
    required this.savingsDao,
    required this.budgetDao,
  });

  @override
  Future<void> deleteGoal(
    String goalId,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      double savingsTotal = 0;
      final savings = await savingsDao.getSavingsByGoalId(goalId);
      for (var saving in savings) {
        savingsTotal += saving.amount;
        await _handleSavingDeletion(saving.id);
      }
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount + savingsTotal,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await _handleGoalsOperationsForDeletion(goalId, pendingOperation);
      await goalsDao.deleteGoal(goalId);
      if (await pendingOperationsDao.hasPendingOperation(currentBudget.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: currentBudget.id,
            entityType: EntityType.budget,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ).toCompanion(),
        );
      }
    });
  }

  @override
  Future<GoalModel?> getGoalById(String goalId) async {
    return goalsDao.getGoalById(goalId).then((value) => value?.toGoalModel());
  }

  @override
  Future<void> insertGoal(
    GoalModel goalModel,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      await goalsDao.insertGoal(goalModel.toGoalsTableCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    });
  }

  @override
  Future<void> updateGoal(
    GoalModel goalModel,
    PendingOperationModel pendingOperationModel,
  ) async {
    return appDatabase.transaction(() async {
      await goalsDao.updateGoal(goalModel.toGoalsTableCompanion());
      if (await pendingOperationsDao.hasPendingOperation(goalModel.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
    });
  }

  @override
  Stream<List<GoalModel>> watchGoals() {
    return goalsDao.watchGoals().map(
      (data) => data.map((d) => d.toGoalModel()).toList(),
    );
  }

  @override
  Future<void> syncRemoteGoals(List<GoalModel> goals) {
    return appDatabase.transaction(() async {
      for (var goal in goals) {
        if (await pendingOperationsDao.hasPendingOperation(goal.id)) {
          continue;
        }
        await goalsDao.upsertGoal(goal.toGoalsTableCompanion());
      }
    });
  }

  @override
  Future<void> completeGoal(
    String goalId,
    PendingOperationModel pendingOperationModel,
  ) {
    return appDatabase.transaction(() async {
      await goalsDao.updateGoalStatus(goalId, GoalStatus.completed);
      if (await pendingOperationsDao.hasPendingOperation(goalId)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
    });
  }

  Future<void> _handleGoalsOperationsForDeletion(
    String goalId,
    PendingOperationModel pendingOperation,
  ) async {
    bool isInsertExist = false;
    final pendingOperationsModels = await pendingOperationsDao
        .getPendingOperationsByEntityId(goalId);
    for (var pendingOperationModel in pendingOperationsModels) {
      if (pendingOperationModel.operationType == Operation.insert) {
        isInsertExist = true;
      }
      await pendingOperationsDao.deleteOperation(
        pendingOperationModel.operationId,
      );
    }
    if (!isInsertExist) {
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    }
  }

  Future<void> _handleSavingDeletion(String savingId) async {
    final pendingOperationsModels = await pendingOperationsDao
        .getPendingOperationsByEntityId(savingId);
    bool isInsertExist = false;
    for (var pendingOperationModel in pendingOperationsModels) {
      if (pendingOperationModel.operationType == Operation.insert) {
        isInsertExist = true;
      }
      await pendingOperationsDao.deleteOperation(
        pendingOperationModel.operationId,
      );
    }
    if (!isInsertExist) {
      await pendingOperationsDao.insertPendingOperation(
        PendingOperationModel(
          operationId: uuid.v4(),
          entityId: savingId,
          entityType: EntityType.saving,
          operation: Operation.delete,
          status: OperationStatus.pending,
          retryCount: 0,
          lastAttemptedAt: null,
          createdAt: DateTime.now(),
        ).toCompanion(),
      );
    }
    await savingsDao.deleteSaving(savingId);
  }
}
