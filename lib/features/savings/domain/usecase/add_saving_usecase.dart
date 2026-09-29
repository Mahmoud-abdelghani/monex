import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';
import 'package:uuid/uuid.dart';

class AddSavingUsecase {
  final SavingsRepository repository;

  AddSavingUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String goalId,
    required double amount,
    required DateTime date,
  }) => repository.addSaving(
    SavingEntity(id: uuid.v4(), goalId: goalId, amount: amount, date: date),
  );
}
