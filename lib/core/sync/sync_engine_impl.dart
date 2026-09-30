import 'dart:developer';

import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/core/sync/retry_policy.dart';
import 'package:monex/core/sync/sync_engine.dart';
import 'package:monex/features/budget/data/source/local/budget_local_data_source.dart';
import 'package:monex/features/budget/data/source/remote/budget_remote_data_source.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:monex/features/goals/data/source/local/goals_local_data_source.dart';
import 'package:monex/features/goals/data/source/remote/goals_remote_data_source.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source.dart';
import 'package:monex/features/reminders/data/sources/local/reminders_local_data_source.dart';
import 'package:monex/features/reminders/data/sources/remote/reminders_remote_data_source.dart';
import 'package:monex/features/savings/data/source/local/savings_local_data_source.dart';
import 'package:monex/features/savings/data/source/remote/savings_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncEngineImpl implements SyncEngine {
  final ExpenseLocalDataSource expenseLocalDataSource;
  final ExpenseRemoteDataSource expenseRemoteDataSource;
  final PendingOperationsLocalDataSource pendingOperationsLocalDataSource;
  final IncomesLocalDataSource incomesLocalDataSource;
  final IncomesRemoteDataSource incomeRemoteDataSource;
  final GoalsRemoteDataSource goalsRemoteDataSource;
  final GoalsLocalDataSource goalsLocalDataSource;
  final SavingsRemoteDataSource savingsRemoteDataSource;
  final SavingsLocalDataSource savingsLocalDataSource;
  final BudgetLocalDataSource budgetLocalDataSource;
  final BudgetRemoteDataSource budgetRemoteDataSource;
  final RemindersRemoteDataSource remindersRemoteDataSource;
  final RemindersLocalDataSource remindersLocalDataSource;

  SyncEngineImpl({
    required this.expenseLocalDataSource,
    required this.expenseRemoteDataSource,
    required this.pendingOperationsLocalDataSource,
    required this.incomesLocalDataSource,
    required this.incomeRemoteDataSource,
    required this.goalsRemoteDataSource,
    required this.goalsLocalDataSource,
    required this.savingsRemoteDataSource,
    required this.savingsLocalDataSource,
    required this.budgetLocalDataSource,
    required this.budgetRemoteDataSource,
    required this.remindersRemoteDataSource,
    required this.remindersLocalDataSource,
  });
  bool isSyncing = false;
  @override
  Future<void> sync() async {
    if (isSyncing) return;
    isSyncing = true;
    try {
      log('Syncing...');
      final operations = await pendingOperationsLocalDataSource
          .getPendingOperations();
      log('${operations.length} pending operations found');
      for (final operation in operations) {
        if (!_canRetry(operation)) {
          continue;
        }

        log('Syncing...1');
        switch (operation.entityType) {
          case EntityType.expense:
            switch (operation.operation) {
              case Operation.insert:
                await _handleExpenseInsert(operation);
                break;

              case Operation.update:
                await _handleExpenseUpdate(operation);
                break;
              case Operation.delete:
                await _handleExpenseDelete(operation);
                break;
            }

          case EntityType.income:
            switch (operation.operation) {
              case Operation.insert:
                await _handleIncomeInsert(operation);
              case Operation.update:
                await _handleIncomeUpdate(operation);
              case Operation.delete:
                await _handleIncomeDelete(operation);
            }

          case EntityType.goal:
            switch (operation.operation) {
              case Operation.insert:
                await _handleGoalInsert(operation);
              case Operation.update:
                await _handleGoalUpdate(operation);
              case Operation.delete:
                await _handleGoalDelete(operation);
            }
          case EntityType.saving:
            switch (operation.operation) {
              case Operation.insert:
                await _handleSavingInsert(operation);
              case Operation.update:
                await _handleSavingUpdate(operation);
              case Operation.delete:
                await _handleSavingDelete(operation);
            }
          case EntityType.budget:
            switch (operation.operation) {
              case Operation.insert:
                await _handleBudgetInsert(operation);
              case Operation.update:
                await _handleBudgetUpdate(operation);
              case Operation.delete:
                log('Unable to delete budget');
            }
          case EntityType.reminder:
            switch (operation.operation) {
              case Operation.insert:
                await _handleReminderInsert(operation);
              case Operation.update:
                await _handleReminderUpdate(operation);
              case Operation.delete:
                await _handleReminderDelete(operation);
            }
        }
      }
      await _syncRemoteExpenses();
      await _syncRemoteIncomes();
      await _syncRemoteGoals();
      await _syncRemoteSavings();
      await _syncRemoteBudget();
      await _syncRemoteReminders();
    } finally {
      isSyncing = false;
    }
  }

  Future<void> _handleIncomeInsert(PendingOperationModel operation) async {
    try {
      final income = await incomesLocalDataSource.getIncomeById(
        operation.entityId,
      );

      if (income == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await incomeRemoteDataSource.processIncomeInsert(
        operationId: operation.operationId,
        income: income,
      );

      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleExpenseInsert(PendingOperationModel operation) async {
    try {
      log('Syncing...32');
      final expense = await expenseLocalDataSource.getExpenseById(
        operation.entityId,
      );

      if (expense == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await expenseRemoteDataSource.processExpenseInsert(
        operationId: operation.operationId,
        expense: expense,
      );

      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
      log('Done');
    } on Exception catch (e) {
      log(e.toString());

      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleGoalInsert(PendingOperationModel operation) async {
    try {
      final goal = await goalsLocalDataSource.getGoalById(operation.entityId);

      if (goal == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await goalsRemoteDataSource.insertGoal(goal, operation.operationId);

      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleSavingInsert(PendingOperationModel operation) async {
    try {
      final saving = await savingsLocalDataSource.getSavingById(
        operation.entityId,
      );

      if (saving == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await savingsRemoteDataSource.insertSaving(saving, operation.operationId);

      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleBudgetInsert(PendingOperationModel operation) async {
    try {
      final budget = await budgetLocalDataSource.getCurrentBudget();
      if (budget == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }
      await budgetRemoteDataSource.createBudget(budget);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleReminderInsert(PendingOperationModel operation) async {
    try {
      final reminder = await remindersLocalDataSource.getReminderById(
        operation.entityId,
      );

      if (reminder == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await remindersRemoteDataSource.insertReminder(
        reminder,
        operation.operationId,
      );

      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _syncRemoteExpenses() async {
    try {
      final remoteExpenses = await expenseRemoteDataSource.getExpenses();
      await expenseLocalDataSource.syncRemoteExpenses(remoteExpenses);
    } on Exception catch (e) {
      log('Error syncing remote expenses: $e');
    }
  }

  Future<void> _syncRemoteSavings() async {
    try {
      final remoteSavings = await savingsRemoteDataSource.getSavings();
      await savingsLocalDataSource.syncRemoteSavings(remoteSavings);
    } on Exception catch (e) {
      log('Error syncing remote savings: $e');
    }
  }

  Future<void> _syncRemoteIncomes() async {
    try {
      final remoteIncomes = await incomeRemoteDataSource.getIncomes();
      await incomesLocalDataSource.syncRemoteIncomes(remoteIncomes);
    } on Exception catch (e) {
      log('Error syncing remote incomes: $e');
    }
  }

  Future<void> _syncRemoteGoals() async {
    try {
      final remoteGoals = await goalsRemoteDataSource.getGoals();
      await goalsLocalDataSource.syncRemoteGoals(remoteGoals);
    } on Exception catch (e) {
      log('Error syncing remote goals: $e');
    }
  }

  Future<void> _syncRemoteBudget() async {
    try {
      final remoteBudget = await budgetRemoteDataSource.getCurrentBudget(
        getIt<SupabaseClient>().auth.currentUser!.id,
      );
      if (remoteBudget == null) {
        return;
      }
      await budgetLocalDataSource.syncRemoteBudget(remoteBudget);
    } on Exception catch (e) {
      log('Error syncing remote budget: $e');
    }
  }

  Future<void> _syncRemoteReminders() async {
    try {
      final remoteReminders = await remindersRemoteDataSource.getReminders();
      await remindersLocalDataSource.syncRemoteReminders(remoteReminders);
    } on Exception catch (e) {
      log('Error syncing remote reminders: $e');
    }
  }

  Future<void> _handleExpenseUpdate(PendingOperationModel operation) async {
    try {
      final expense = await expenseLocalDataSource.getExpenseById(
        operation.entityId,
      );

      if (expense == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await expenseRemoteDataSource.updateExpense(expense);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleIncomeUpdate(PendingOperationModel operation) async {
    try {
      final income = await incomesLocalDataSource.getIncomeById(
        operation.entityId,
      );

      if (income == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await incomeRemoteDataSource.updateIncome(income);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleGoalUpdate(PendingOperationModel operation) async {
    try {
      final goal = await goalsLocalDataSource.getGoalById(operation.entityId);

      if (goal == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }
      await goalsRemoteDataSource.updateGoal(goal);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleSavingUpdate(PendingOperationModel operation) async {
    try {
      final saving = await savingsLocalDataSource.getSavingById(
        operation.entityId,
      );

      if (saving == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await savingsRemoteDataSource.updateSaving(saving);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleBudgetUpdate(PendingOperationModel operation) async {
    try {
      final budget = await budgetLocalDataSource.getCurrentBudget();
      if (budget == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }
      await budgetRemoteDataSource.updateBudget(budget);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleReminderUpdate(PendingOperationModel operation) async {
    try {
      final reminder = await remindersLocalDataSource.getReminderById(
        operation.entityId,
      );

      if (reminder == null) {
        await pendingOperationsLocalDataSource.deleteOperation(
          operation.operationId,
        );
        return;
      }

      await remindersRemoteDataSource.updateReminder(reminder);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleExpenseDelete(PendingOperationModel operation) async {
    try {
      await expenseRemoteDataSource.deleteExpense(operation.entityId);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleIncomeDelete(PendingOperationModel operation) async {
    try {
      await incomeRemoteDataSource.deleteIncome(operation.entityId);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleGoalDelete(PendingOperationModel operation) async {
    try {
      await goalsRemoteDataSource.deleteGoal(operation.entityId);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleSavingDelete(PendingOperationModel operation) async {
    try {
      await savingsRemoteDataSource.deleteSaving(operation.entityId);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  Future<void> _handleReminderDelete(PendingOperationModel operation) async {
    try {
      await remindersRemoteDataSource.deleteReminder(operation.entityId);
      await pendingOperationsLocalDataSource.deleteOperation(
        operation.operationId,
      );
    } on Exception catch (e) {
      log(e.toString());
      await pendingOperationsLocalDataSource.recordRetry(operation.operationId);
    }
  }

  bool _canRetry(PendingOperationModel operation) {
    if (operation.retryCount >= RetryPolicy.maxRetries) {
      return false;
    }

    if (operation.lastAttemptedAt == null) {
      return true;
    }

    final retryDuration = RetryPolicy.getRetryDelay(operation.retryCount);

    return DateTime.now().isAfter(
      operation.lastAttemptedAt!.add(retryDuration),
    );
  }
}
