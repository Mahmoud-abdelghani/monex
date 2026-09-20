import 'package:monex/features/expense/domain/entities/expense_category_entity.dart';

class ExpenseEntity {
  final String id;
  final String title;
  final String userId;
  final double amount;
  final String  categoryId;
  final String method;
  final DateTime date;
  ExpenseEntity({
    required this.id,
    required this.title,
    required this.userId,
    required this.amount,
    required this.categoryId,
    required this.date,
    required this.method,
  });
}
