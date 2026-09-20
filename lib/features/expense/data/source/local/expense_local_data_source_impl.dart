import 'dart:developer';

import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/expenses_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source_impl.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/expense/data/mappers/expense_local_mapper.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final ExpensesDao expenseDao;
  final PendingOperationsDao pendingOperationsDao;
  final AppDatabase appDatabase;

  ExpenseLocalDataSourceImpl({
    required this.expenseDao,
    required this.pendingOperationsDao,
    required this.appDatabase,
  });
  @override
  Future<void> insertExpense(
    ExpenseModel expense,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      await expenseDao.insertExpense(expense.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    });
  }

  @override
  Future<void> deleteExpense(
    String id,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      await expenseDao.deleteExpense(id);
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
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
      await expenseDao.updateExpense(expense.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(expense.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperation.toCompanion(),
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
}
