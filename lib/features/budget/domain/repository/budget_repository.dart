import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';

abstract class BudgetRepository {
  Future<Either<Failure, BudgetEntity?>> getCurrentBudget();
  Future<Either<Failure, void>> createBudget(BudgetEntity budget);
  Future<Either<Failure, void>> updateBudget(BudgetEntity budget);
  Stream<Either<Failure, BudgetEntity?>> watchBudget();
}
