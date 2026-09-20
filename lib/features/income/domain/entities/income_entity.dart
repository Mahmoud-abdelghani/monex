import 'package:monex/features/income/domain/entities/income_category_entity.dart';

class IncomeEntity {
  final String id;
  final String title;
  final String userId;
  final double amount;
  final String categoryId;
  final String method;
  final DateTime date;
  IncomeEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.userId,
    required this.date,
    required this.method,
  });
}
