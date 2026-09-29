import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';

class GetCurrentBudgetUsecase {
  final BudgetRepository repository;
  GetCurrentBudgetUsecase(this.repository);

  Future<Either<Failure, BudgetEntity?>> call() async => await repository.getCurrentBudget();
}