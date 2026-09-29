import 'package:monex/features/savings/domain/entities/saving_entity.dart';

class SavingModel {
   final String id;
  final String goalId;
  final double amount;
  final DateTime date;

  SavingModel({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goal_id': goalId,
      'amount': amount,
      'date': date.toUtc().toIso8601String(),
    };
  }

  factory SavingModel.fromJson(Map<String, dynamic> map) {
    return SavingModel(
      id: map['id'],
      goalId: map['goal_id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }

  SavingEntity toEntity() {
    return SavingEntity(
      id: id,
      goalId: goalId,
      amount: amount,
      date: date,
    );
  }

  factory SavingModel.fromEntity(SavingEntity entity) {
    return SavingModel(
      id: entity.id,
      goalId: entity.goalId,
      amount: entity.amount,
      date: entity.date,
    );
  }
}