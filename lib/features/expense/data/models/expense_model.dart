import 'package:monex/features/expense/domain/entities/expense_category_entity.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';

class ExpenseModel {
  final String id;
  final String userId;
  final String title;
  final String method;
  final double amount;
  final String categoryId;
  final DateTime date;

  ExpenseModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.method,
    required this.amount,
    required this.categoryId,
    required this.date,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      method: json['method'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['category_id'] as String,
      date: DateTime.parse(json['date'] as String).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'method': method,
      'amount': amount,
      'category_id': categoryId,
      'date': date.toUtc().toIso8601String(),
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      userId:entity.userId ,
      title: entity.title,
      method: entity.method,
      amount: entity.amount,
      categoryId: entity.categoryId,
      date: entity.date,
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
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
