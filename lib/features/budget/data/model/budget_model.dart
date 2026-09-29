import 'package:monex/features/budget/domain/entities/budget_entity.dart';

class BudgetModel {
  final String id;
  final double amount;

  BudgetModel({required this.id, required this.amount});

  factory BudgetModel.fromJson(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] as String,
      amount: map['balance'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'balance': amount};
  }

  factory BudgetModel.fromEntity(BudgetEntity entity) {
    return BudgetModel(id: entity.id, amount: entity.balance);
  }

  BudgetEntity toEntity() {
    return BudgetEntity(id: id, balance: amount);
  }
}
