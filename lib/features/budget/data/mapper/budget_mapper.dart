import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/budget/data/model/budget_model.dart';

extension BudgetLocalMapper on BudgetModel {
  BudgetTableCompanion toCompanion() => BudgetTableCompanion.insert(id: id, amount: amount);
}

extension BudgetTableDataMapper on BudgetTableData {
  BudgetModel toModel() => BudgetModel(id: id, amount: amount);
}