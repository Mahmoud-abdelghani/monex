import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/dao/reminders_dao.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/reminders/data/mappers/reminder_local_mapper.dart';
import 'package:monex/features/reminders/data/models/reminder_model.dart';
import 'package:monex/features/reminders/data/sources/local/reminders_local_data_source.dart';

class RemindersLocalDataSourceImpl implements RemindersLocalDataSource {
  final RemindersDao remindersDao;
  final PendingOperationsDao pendingOperationsDao;
  final AppDatabase appDatabase;

  RemindersLocalDataSourceImpl({
    required this.remindersDao,
    required this.pendingOperationsDao,
    required this.appDatabase,
  });

  @override
  Future<void> addReminder(
    ReminderModel data,
    PendingOperationModel pendingOperationModel,
  ) async {
    return appDatabase.transaction(() async {
      await remindersDao.insertReminder(data.toCompanion());
      await pendingOperationsDao.insertPendingOperation(
        pendingOperationModel.toCompanion(),
      );
    });
  }

  @override
  Future<void> deleteReminder(
    String id,
    PendingOperationModel pendingOperationModel,
  ) {
    return appDatabase.transaction(() async {
      final pendingOperations = await pendingOperationsDao
          .getPendingOperationsByEntityId(id);
      bool hasPendingInsert = false;
      for (var pendingOperation in pendingOperations) {
        if (pendingOperation.operationType == Operation.insert) {
          hasPendingInsert = true;
        }
        await pendingOperationsDao.deleteOperation(
          pendingOperation.operationId,
        );
      }
      if (!hasPendingInsert) {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
      await remindersDao.deleteReminder(id);
    });
  }

  @override
  Future<ReminderModel?> getReminderById(String id) {
    return remindersDao.getReminderById(id).then((value) => value?.toModel());
  }

  @override
  Future<void> syncRemoteReminders(List<ReminderModel> reminders) async {
    return await appDatabase.transaction(() async {
      for (var reminder in reminders) {
        final hasPending = await pendingOperationsDao.hasPendingOperation(
          reminder.id,
        );
        if (hasPending) {
          continue;
        }
        await remindersDao.upsertReminder(reminder.toCompanion());
      }
    });
  }

  @override
  Future<void> updateReminder(
    ReminderModel data,
    PendingOperationModel pendingOperationModel,
  ) async {
    await appDatabase.transaction(() async {
      await remindersDao.updateReminder(data.toCompanion());
      if (await pendingOperationsDao.hasPendingOperation(data.id)) {
      } else {
        await pendingOperationsDao.insertPendingOperation(
          pendingOperationModel.toCompanion(),
        );
      }
    });
  }

  @override
  Stream<List<ReminderModel>> watchReminders() {
    return remindersDao.watchReminders().map(
      (event) => event.map((e) => e.toModel()).toList(),
    );
  }
}
