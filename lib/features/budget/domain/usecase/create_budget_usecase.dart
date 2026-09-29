import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';

class CreateBudgetUsecase {
  final BudgetRepository budgetRepository;
  CreateBudgetUsecase(this.budgetRepository);

  Future<Either<Failure, void>> call({required double balance}) async =>
      await budgetRepository.createBudget(
        BudgetEntity(id: uuid.v4(), balance: balance),
      );
}
