import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/reminders/data/models/reminder_model.dart';

extension ReminderLocalMapper on ReminderModel {
  RemindersTableCompanion toCompanion() => RemindersTableCompanion(
    id: Value(id),
    title: Value(title),
    amount: Value(amount),
    frequency: Value(frequency),
    deadline: Value(deadline),
    scheduleDate: Value(scheduleDate),
  );
}

extension RemindersTableDataMapper on RemindersTableData {
  ReminderModel toModel() => ReminderModel(
    id: id,
    title: title,
    amount: amount,
    frequency: frequency,
    deadline: deadline, scheduleDate: scheduleDate,
  );
}