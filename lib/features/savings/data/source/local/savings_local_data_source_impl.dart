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
import 'package:monex/features/savings/data/mappers/savings_local_mappers.dart';
import 'package:monex/features/savings/data/models/saving_model.dart';
import 'package:monex/features/savings/data/source/local/savings_local_data_source.dart';

class SavingsLocalDataSourceImpl implements SavingsLocalDataSource {
  final AppDatabase appDatabase;
  final PendingOperationsDao pendingOperationsDao;
  final SavingsDao savingsDao;
  final GoalsDao goalDao;
  final BudgetDao budgetDao;
  SavingsLocalDataSourceImpl({
    required this.appDatabase,
    required this.pendingOperationsDao,
    required this.savingsDao,
    required this.budgetDao,
    required this.goalDao,
  });

  @override
  Future<void> deleteSaving(
    String savingId,
    PendingOperationModel pendingOperationModel,
  ) async {
    return appDatabase.transaction(() async {
      final oldSavingModel = (await savingsDao.getSavingById(savingId))!;
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount + oldSavingModel.amount,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await savingsDao.deleteSaving(savingId);
      await _clearPendingOperations(savingId, pendingOperationModel);
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
  Future<SavingModel?> getSavingById(String savingId) async {
    return savingsDao
        .getSavingById(savingId)
        .then((saving) => saving?.toModel());
  }

  @override
  Future<List<SavingModel>> getSavingsByGoalId(String goalId) async {
    return savingsDao
        .getSavingsByGoalId(goalId)
        .then((savings) => savings.map((saving) => saving.toModel()).toList());
  }

  @override
  Future<void> insertSaving(
    SavingModel savingModel,
    PendingOperationModel pendingOperationModel,
  ) async {
    return appDatabase.transaction(() async {
      final goal = await goalDao.getGoalById(savingModel.goalId);
      if (goal == null) {
        throw Exception('Goal not found');
      }
      if (await _exceedTargetAmount(goal.toGoalModel(), savingModel.amount)) {
        throw Exception('Target amount exceeded');
      }
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount - savingModel.amount,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await savingsDao.insertSaving(savingModel.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperationModel.toCompanion(),
      );
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
  Future<void> syncRemoteSavings(List<SavingModel> savings) async {
    await appDatabase.transaction(() async {
      for (var saving in savings) {
        if (await pendingOperationsDao.hasPendingOperation(saving.id)) {
          continue;
        }
        await savingsDao.upsertSaving(saving.toCompanion());
      }
    });
  }

  @override
  Future<void> updateSaving(
    SavingModel savingModel,
    PendingOperationModel pendingOperationModel,
  ) async {
    return appDatabase.transaction(() async {
      final goal = await goalDao.getGoalById(savingModel.goalId);
      if (goal == null) {
        throw Exception('Goal not found');
      }
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final oldSavingModel = (await savingsDao.getSavingById(savingModel.id))!;
      final delta = savingModel.amount - oldSavingModel.amount;
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount - delta,
      );
      if (await _exceedTargetAmountOnUpdate(
        goal.toGoalModel(),
        newBudget.amount,
        savingModel.id,
      )) {
        throw Exception('Target amount exceeded');
      }
      await budgetDao.updateBudget(newBudget.toCompanion());
      await savingsDao.updateSaving(savingModel.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(savingModel.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
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
  Stream<List<SavingModel>> watchSavings() {
    return savingsDao.watchSavings().map(
      (data) => data.map((d) => d.toModel()).toList(),
    );
  }

  Future<void> _clearPendingOperations(
    String entityId,
    PendingOperationModel pendingOperation,
  ) async {
    bool insertExist = false;
    final operations = await pendingOperationsDao
        .getPendingOperationsByEntityId(entityId);
    for (var operation in operations) {
      if (operation.operationType == Operation.insert) {
        insertExist = true;
      }
      await pendingOperationsDao.deleteOperation(operation.operationId);
    }
    if (!insertExist) {
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    }
  }

  Future<bool> _exceedTargetAmount(GoalModel goal, double amount) async {
    final savingsOfThisGoal = await savingsDao.getSavingsByGoalId(goal.id);

    double totalSavings = 0;
    for (var saving in savingsOfThisGoal) {
      totalSavings += saving.amount;
    }
    totalSavings += amount;
    return totalSavings > goal.targetAmount;
  }

  Future<bool> _exceedTargetAmountOnUpdate(
    GoalModel goal,
    double amount,
    String oldSavingId,
  ) async {
    final savingsOfThisGoal = await savingsDao.getSavingsByGoalId(goal.id);

    double totalSavings = 0;
    for (var saving in savingsOfThisGoal) {
      if (oldSavingId == saving.id) {
        continue;
      }
      totalSavings += saving.amount;
    }
    totalSavings += amount;
    return totalSavings > goal.targetAmount;
  }
}
