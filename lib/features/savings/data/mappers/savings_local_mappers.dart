import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/savings/data/models/saving_model.dart';

extension SavingsLocalMappers on SavingModel {
  SavingsTableCompanion toCompanion() => SavingsTableCompanion(
    id: Value(id),
    amount: Value(amount),
    goalId: Value(goalId),
    date: Value(date),
  );
}

extension SavingsTableDataMapper on SavingsTableData {
  SavingModel toModel() => SavingModel(
    id: id,
    goalId: goalId,
    amount: amount,
    date: date,
  );
}
