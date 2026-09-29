import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';

class WatchBudgetUsecase {
  final BudgetRepository repository;
  WatchBudgetUsecase(this.repository);

  Stream<Either<Failure, BudgetEntity?>> call() => repository.watchBudget();
}