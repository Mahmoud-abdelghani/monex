import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';

abstract class IncomesRepository {
  Future<Either<Failure, void>> addIncome(IncomeEntity income);
  Future<Either<Failure, void>> deleteIncome(String incomeId);
  Future<Either<Failure, void>> updateIncome(IncomeEntity income);
  Future<Either<Failure, IncomeEntity?>> getIncomeById(String id);
  Stream< Either<Failure, List<IncomeEntity>>> watchIncomes();
}

