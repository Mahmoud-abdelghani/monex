import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/budget_dao.dart';
import 'package:monex/core/local/database/dao/incomes_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/mapper/budget_mapper.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/income/data/mappers/income_local_mapper.dart';
import 'package:monex/features/income/data/models/income_model.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';

class IncomesLocalDataSourceImpl implements IncomesLocalDataSource {
  final AppDatabase appDatabase;
  final PendingOperationsDao pendingOperationsDao;
  final IncomesDao incomesDao;
  final BudgetDao budgetDao;

  IncomesLocalDataSourceImpl({
    required this.appDatabase,
    required this.pendingOperationsDao,
    required this.incomesDao,
    required this.budgetDao,
  });

  @override
  Future<void> deleteIncome(
    String id,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      final oldIncomeModel = (await incomesDao.getIncomeById(id))!.toModel();
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount - oldIncomeModel.amount,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await incomesDao.deleteIncome(id);
      await _cleanUpPendingOperations(id, pendingOperation);
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
  Future<IncomeModel?> getIncomeById(String id) async {
    return incomesDao.getIncomeById(id).then((data) => data?.toModel());
  }

  @override
  Future<void> insertIncome(
    IncomeModel data,
    PendingOperationModel pendingOperation,
  ) {
    return appDatabase.transaction(() async {
      
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount + data.amount,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await incomesDao.insertIncome(data.toCompanion());
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
  Future<void> syncRemoteIncomes(List<IncomeModel> incomes) async {
    await appDatabase.transaction(() async {
      for (var income in incomes) {
        final hasPending = await pendingOperationsDao.hasPendingOperation(
          income.id,
        );
        if (hasPending) {
          continue;
        }
        await incomesDao.upsertIncome(income.toCompanion());
      }
    });
  }

  @override
  Future<void> updateIncome(
    IncomeModel data,
    PendingOperationModel pendingOperation,
  ) {
    return appDatabase.transaction(() async {
      final oldIncomeModel = (await incomesDao.getIncomeById(
        data.id,
      ))!.toModel();
      final delta = data.amount - oldIncomeModel.amount;
      final currentBudget = (await budgetDao.getCurrentBudget())!.toModel();
      final newBudget = BudgetModel(
        id: currentBudget.id,
        amount: currentBudget.amount + delta,
      );
      await budgetDao.updateBudget(newBudget.toCompanion());
      await incomesDao.updateIncome(data.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(data.id)) {
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
    });
  }

  @override
  Stream<List<IncomeModel>> watchIncomes() {
    return incomesDao.watchIncomes().map(
      (data) => data.map((d) => d.toModel()).toList(),
    );
  }

  Future<void> _cleanUpPendingOperations(
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
}
