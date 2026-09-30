import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<Either<Failure, void>> addReminder(ReminderEntity reminder);

  Future<Either<Failure, void>> updateReminder(ReminderEntity reminder);

  Future<Either<Failure, void>> deleteReminder(String id);

  Stream<Either<Failure, List<ReminderEntity>>> watchReminders();

  Future<Either<Failure, ReminderEntity?>> getReminderById(String id);
}
