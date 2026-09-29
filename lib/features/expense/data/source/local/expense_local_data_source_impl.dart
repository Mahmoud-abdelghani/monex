import 'dart:developer';

import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/budget_dao.dart';
import 'package:monex/core/local/database/dao/expenses_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/mapper/budget_mapper.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/expense/data/mappers/expense_local_mapper.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final ExpensesDao expenseDao;
  final PendingOperationsDao pendingOperationsDao;
  final AppDatabase appDatabase;
  final BudgetDao budgetDao;

  ExpenseLocalDataSourceImpl({
    required this.expenseDao,
    required this.pendingOperationsDao,
    required this.appDatabase,
    required this.budgetDao,
  });
  @override
  Future<void> insertExpense(
    ExpenseModel expense,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount - expense.amount,
      );
      await expenseDao.insertExpense(expense.toCompanion());
      await budgetDao.updateBudget(newBudget.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
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
  Future<void> deleteExpense(
    String id,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      final expense = (await expenseDao.getExpenseById(id))!.toModel();
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount + expense.amount,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());

      await expenseDao.deleteExpense(id);
      await _clearPendingOperationsForDelete(id);

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
  Future<ExpenseModel?> getExpenseById(String id) async {
    return expenseDao.getExpenseById(id).then((data) => data?.toModel());
  }

  @override
  Future<bool> updateExpense(
    ExpenseModel expense,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      final oldExpenseModel = (await expenseDao.getExpenseById(
        expense.id,
      ))!.toModel();
      final delta = expense.amount - oldExpenseModel.amount;
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount - delta,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await expenseDao.updateExpense(expense.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(expense.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperation.toCompanion(),
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
      log(pendingOperationsDao.getPendingOperations().toString());
      return true;
    });
  }

  @override
  Stream<List<ExpenseModel>> watchExpenses() {
    return expenseDao.watchExpenses().map(
      (data) => data.map((d) => d.toModel()).toList(),
    );
  }

  @override
  Future<void> syncRemoteExpenses(List<ExpenseModel> expenses) async {
    await appDatabase.transaction(() async {
      for (var expense in expenses) {
        final hasPending = await pendingOperationsDao.hasPendingOperation(
          expense.id,
        );
        if (hasPending) {
          continue;
        }
        await expenseDao.upsertExpense(expense.toCompanion());
      }
    });
  }

  Future<void> _clearPendingOperationsForDelete(String entityId) async {
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
        PendingOperationModel(
          operationId: uuid.v4(),
          entityId: entityId,
          entityType: EntityType.expense,
          operation: Operation.delete,
          status: OperationStatus.pending,
          retryCount: 0,
          lastAttemptedAt: null,
          createdAt: DateTime.now(),
        ).toCompanion(),
      );
    }
  }
}
