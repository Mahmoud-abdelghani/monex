import 'package:monex/features/reminders/data/models/reminder_model.dart';

abstract class RemindersRemoteDataSource {
  Future<void> insertReminder(ReminderModel data, String operationId);
  Future<void> updateReminder(ReminderModel data);
  Future<void> deleteReminder(String id);
  Future<List<ReminderModel>> getReminders();
  Future<ReminderModel> getReminderById(String id);
}
