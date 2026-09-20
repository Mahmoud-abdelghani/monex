import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';

class WatchIncomesUsecase {
  final IncomesRepository repository;

  WatchIncomesUsecase(this.repository);

  Stream<Either<Failure, List<IncomeEntity>>> call() => repository.watchIncomes();
}