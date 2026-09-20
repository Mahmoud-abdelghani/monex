import 'package:monex/features/income/domain/entities/income_entity.dart';

class IncomeModel {
  final String id;
  final String userId;
  final String title;
  final String method;
  final double amount;
  final String categoryId;
  final DateTime date;

  IncomeModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.method,
    required this.amount,
    required this.categoryId,
    required this.date,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    method: json['method'] as String,
    amount: json['amount'] as double,
    categoryId: json['category_id'] as String,
    date: DateTime.parse(json['date'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'method': method,
    'amount': amount,
    'category_id': categoryId,
    'date': date.toUtc().toIso8601String(),
  };

  IncomeEntity toEntity() => IncomeEntity(
    id: id,
    userId: userId,
    title: title,
    method: method,
    amount: amount,
    categoryId: categoryId,
    date: date,
  );

  factory IncomeModel.fromEntity(IncomeEntity entity) => IncomeModel(
    id: entity.id,
    userId: entity.userId,
    title: entity.title,
    method: entity.method,
    amount: entity.amount,
    categoryId: entity.categoryId,
    date: entity.date,
  );
}
