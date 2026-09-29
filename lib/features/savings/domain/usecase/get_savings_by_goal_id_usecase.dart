import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class GetSavingsByGoalIdUsecase {
  final SavingsRepository savingsRepository;

  GetSavingsByGoalIdUsecase(this.savingsRepository);

  Future<Either<Failure, List<SavingEntity>>> call(String goalId) =>
      savingsRepository.getSavingsByGoalId(goalId);
}
