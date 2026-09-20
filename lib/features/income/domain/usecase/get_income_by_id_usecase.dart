import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';

class GetIncomeByIdUsecase {
  final IncomesRepository repository;

  GetIncomeByIdUsecase(this.repository);

  Future<Either<Failure, IncomeEntity?>> call(String id) => repository.getIncomeById(id);
}