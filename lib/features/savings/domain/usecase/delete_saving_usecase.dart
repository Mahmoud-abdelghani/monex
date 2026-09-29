import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class DeleteSavingUsecase {
  final SavingsRepository repository;
  DeleteSavingUsecase(this.repository);
  Future<Either<Failure, void>> call(String savingId) => repository.deleteSaving(savingId);
}