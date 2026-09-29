import 'package:monex/features/savings/data/models/saving_model.dart';

abstract class SavingsRemoteDataSource {
  Future<void> insertSaving(SavingModel saving, String operationId);
  Future<void> updateSaving(SavingModel saving);
  Future<void> deleteSaving(String savingId);
  Future<SavingModel?> getSavingById(String savingId);
  Future<List<SavingModel>> getSavingsByGoalId(String goalId);
  Future<List<SavingModel>> getSavings();
  
}