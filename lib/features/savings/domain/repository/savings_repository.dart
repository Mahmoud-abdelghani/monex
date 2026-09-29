import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';

abstract class SavingsRepository {
  Future<Either<Failure, void>> addSaving(SavingEntity saving);
  Future<Either<Failure, void>> updateSaving(SavingEntity saving);
  Future<Either<Failure, void>> deleteSaving(String savingId);
  Future<Either<Failure, SavingEntity?>> getSavingById(String savingId);
  Future<Either<Failure, List<SavingEntity>>>getSavingsByGoalId(String goalId);
  Stream<Either<Failure, List<SavingEntity>>> watchSavings();
}
