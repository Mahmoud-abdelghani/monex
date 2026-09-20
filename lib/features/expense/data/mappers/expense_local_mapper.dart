import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';

extension ExpenseLocalMapper on ExpenseModel {
  ExpensesTableCompanion toCompanion() {
    return ExpensesTableCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      categoryId: Value(categoryId),
      method: Value(method),
      date: Value(date),
      userId: Value(userId),
    );
  }
}

extension ExpensesTableDataMapper on ExpensesTableData {
  ExpenseModel toModel() {
    return ExpenseModel(
      id: id,
      title: title,
      amount: amount,
      categoryId: categoryId,
      method: method,
      date: date,
      userId: userId,
    );
  }
}
