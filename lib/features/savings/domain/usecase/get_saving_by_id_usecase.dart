import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class GetSavingByIdUsecase {
  final SavingsRepository repository;

  GetSavingByIdUsecase(this.repository);

  Future<Either<Failure, SavingEntity?>> call(String savingId) => repository.getSavingById(savingId);
}