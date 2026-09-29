import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';

class WatchSavingsUsecase {
  final SavingsRepository repository;

  WatchSavingsUsecase(this.repository);

  Stream<Either<Failure, List<SavingEntity>>> call() =>
      repository.watchSavings();
}
