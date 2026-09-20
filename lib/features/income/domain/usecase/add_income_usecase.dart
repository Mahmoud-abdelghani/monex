import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';
import 'package:uuid/uuid.dart';

class AddIncomeUsecase {
  final IncomesRepository repository;

  AddIncomeUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String title,
    required String method,
    required double amount,
    required String userId,
    required String categoryId,
    required DateTime date,
  }) => repository.addIncome(
    IncomeEntity(
      title: title,
      method: method,
      amount: amount,
      categoryId: categoryId,
      date: date,
      id: Uuid().v4(),
      userId: userId,
    ),
  );
}
