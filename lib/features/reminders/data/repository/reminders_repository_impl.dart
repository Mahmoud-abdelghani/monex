import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/reminders/data/models/reminder_model.dart';
import 'package:monex/features/reminders/data/sources/local/reminders_local_data_source.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class RemindersRepositoryImpl implements ReminderRepository {
  final RemindersLocalDataSource remindersLocalDataSource;

  RemindersRepositoryImpl(this.remindersLocalDataSource);

  @override
  Future<Either<Failure, void>> addReminder(ReminderEntity reminder) async {
    try {
      return right(
        await remindersLocalDataSource.addReminder(
          ReminderModel.fromEntity(reminder),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: reminder.id,
            entityType: EntityType.reminder,
            operation: Operation.insert,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReminder(String id) async {
    try {
      return right(
        await remindersLocalDataSource.deleteReminder(
          id,
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: id,
            entityType: EntityType.reminder,
            operation: Operation.delete,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity?>> getReminderById(String id) async {
    try {
      return right(
        (await remindersLocalDataSource.getReminderById(id))!.toEntity(),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReminder(ReminderEntity reminder) async {
    try {
      return right(
        await remindersLocalDataSource.updateReminder(
          ReminderModel.fromEntity(reminder),
          PendingOperationModel(
            operationId: uuid.v4(),
            entityId: reminder.id,
            entityType: EntityType.reminder,
            operation: Operation.update,
            status: OperationStatus.pending,
            retryCount: 0,
            lastAttemptedAt: null,
            createdAt: DateTime.now(),
          ),
        ),
      );
    } on Exception catch (e) {
      return left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ReminderEntity>>> watchReminders() async* {
    try {
      await for (final data in remindersLocalDataSource.watchReminders()) {
        yield right(data.map((e) => e.toEntity()).toList());
      }
    } on Exception catch (e) {
      yield left(LocalStorageFailure(e.toString()));
    }
  }
}
