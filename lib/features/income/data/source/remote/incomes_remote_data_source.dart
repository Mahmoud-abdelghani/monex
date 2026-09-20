import 'package:monex/features/income/data/models/income_model.dart';

abstract class IncomesRemoteDataSource {
  Future<List<IncomeModel>> getIncomes();
  Future<IncomeModel> getIncomeById(String id);
  Future<void> insertIncome(IncomeModel data);
  Future<void> updateIncome(IncomeModel data);
  Future<void> deleteIncome(String id);
  Future<void> processIncomeInsert({
    required String operationId,
    required IncomeModel income,
  });
}
