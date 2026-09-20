import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';

class DeleteIncomeUsecase {
  final IncomesRepository repository;
  DeleteIncomeUsecase(this.repository);

  Future<Either<Failure, void>> call(String incomeId) => repository.deleteIncome(incomeId);
}