import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/reminders/data/models/reminder_model.dart';

abstract class RemindersLocalDataSource {
  Future<void> addReminder(
    ReminderModel data,
    PendingOperationModel pendingOperationModel,
  );
  Future<void> updateReminder(
    ReminderModel data,
    PendingOperationModel pendingOperationModel,
  );
  Future<void> deleteReminder(
    String id,
    PendingOperationModel pendingOperationModel,
  );
  Future<ReminderModel?> getReminderById(String id);
  Stream<List<ReminderModel>> watchReminders();
  Future<void> syncRemoteReminders(List<ReminderModel> reminders);
}
