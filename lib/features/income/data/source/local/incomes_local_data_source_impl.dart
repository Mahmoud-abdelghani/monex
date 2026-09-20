import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/incomes_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/income/data/mappers/income_local_mapper.dart';
import 'package:monex/features/income/data/models/income_model.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';

class IncomesLocalDataSourceImpl implements IncomesLocalDataSource {
  final AppDatabase appDatabase;
  final PendingOperationsDao pendingOperationsDao;
  final IncomesDao incomesDao;

  IncomesLocalDataSourceImpl( {
    required this.appDatabase,
    required this.pendingOperationsDao,
    required this.incomesDao,
  });

  @override
  Future<void> deleteIncome(
    String id,
    PendingOperationModel pendingOperation,
  ) async {
    return appDatabase.transaction(() async {
      await incomesDao.deleteIncome(id);
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
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
      await incomesDao.insertIncome(data.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    });
  }

  @override
  Future<void> syncRemoteIncomes(List<IncomeModel> incomes) async {
    for (var income in incomes) {
      final hasPending = await pendingOperationsDao.hasPendingOperation(
        income.id,
      );
      if (hasPending) {
        continue;
      }
      incomesDao.upsertIncome(income.toCompanion());
    }
  }

  @override
  Future<void> updateIncome(
    IncomeModel data,
    PendingOperationModel pendingOperation,
  ) {
    return appDatabase.transaction(() async {
      await incomesDao.updateIncome(data.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperation.toCompanion(),
      );
    });
  }

  @override
  Stream<List<IncomeModel>> watchIncomes() {
    return incomesDao.watchIncomes().map(
      (data) => data.map((d) => d.toModel()).toList(),
    );
  }
}
