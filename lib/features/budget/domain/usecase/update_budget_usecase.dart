import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';

class UpdateBudgetUsecase {
  final BudgetRepository repository;

  UpdateBudgetUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String budgetId,
    required double balance,
  }) async => await repository.updateBudget(
    BudgetEntity(id: budgetId, balance: balance),
  );
}