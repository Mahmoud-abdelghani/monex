import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/budget_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/budget/data/mapper/budget_mapper.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/budget/data/source/local/budget_local_data_source.dart';

class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final AppDatabase appDatabase;
  final PendingOperationsDao pendingOperationsDao;
  final BudgetDao budgetDao;
  

  BudgetLocalDataSourceImpl({
    required this.appDatabase,
    required this.pendingOperationsDao,
    required this.budgetDao,
  });

  @override
  Future<void> createBudget(
    BudgetModel data,
    PendingOperationModel pendingOperationModel,
  ) async {
    return await appDatabase.transaction(() async {
      await budgetDao.insertBudget(data.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperationModel.toCompanion(),
      );
    });
  }

  @override
  Future<BudgetModel?> getCurrentBudget() async {
    final result = await budgetDao.getCurrentBudget();
    return result?.toModel();
  }

  @override
  Future<void> updateBudget(
    BudgetModel data,
    PendingOperationModel pendingOperationModel,
  ) async {
    await appDatabase.transaction(() async {
      await budgetDao.updateBudget(data.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(data.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
    });
  }

  @override
  Stream<BudgetModel?> watchBudget() {
    return budgetDao.watchBudget().map((event) => event?.toModel());
  }

  @override
  Future<void> syncRemoteBudget(BudgetModel data) async {
    return appDatabase.transaction(() async {
      await budgetDao.upsertBudget(data.toCompanion());
    });
  }
}
