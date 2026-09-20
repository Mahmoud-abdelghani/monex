import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/income/data/models/income_model.dart';

extension IncomeLocalMapper on IncomeModel {

  IncomesTableCompanion toCompanion (){
    return IncomesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      method: Value(method),
      amount: Value(amount),
      categoryId: Value(categoryId),
      date: Value(date),
    );
  }


}

extension IncomeDataModel on IncomesTableData {
  IncomeModel toModel() {
    return IncomeModel(
      id: id,
      userId: userId,
      title: title,
      method: method,
      amount: amount,
      categoryId: categoryId,
      date: date,
    );
  }
}