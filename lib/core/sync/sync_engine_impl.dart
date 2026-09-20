import 'dart:developer';

import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source_impl.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/core/sync/retry_policy.dart';
import 'package:monex/core/sync/sync_engine.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source.dart';

class SyncEngineImpl implements SyncEngine {
  final ExpenseLocalDataSource expenseLocalDataSource;
  final ExpenseRemoteDataSource expenseRemoteDataSource;
  final PendingOperationsLocalDataSource pendingOperationsLocalDataSource;
  final IncomesLocalDataSource incomesLocalDataSource;
  final IncomesRemoteDataSource incomeRemoteDataSource;

  SyncEngineImpl({
    required this.expenseLocalDataSource,
    required this.expenseRemoteDataSource,
    required this.pendingOperationsLocalDataSource,
    required this.incomesLocalDataSource,
    required this.incomeRemoteDataSource,
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
            throw UnimplementedError();
        }
      }
      await _syncRemoteExpenses();
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

  Future<void> _syncRemoteExpenses() async {
    try {
      final remoteExpenses = await expenseRemoteDataSource.getExpenses();
      await expenseLocalDataSource.syncRemoteExpenses(remoteExpenses);
    } on Exception catch (e) {
      log('Error syncing remote expenses: $e');
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
