import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class UpdateSavingUsecase {
  final SavingsRepository repository;
  UpdateSavingUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String goalId,
    required double amount,
    required DateTime date,
    required String id

  }) => repository.updateSaving(
    SavingEntity(id: id, goalId: goalId, amount: amount, date: date),
  );
}