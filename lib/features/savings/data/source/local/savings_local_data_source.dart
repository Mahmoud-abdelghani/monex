import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/features/savings/data/models/saving_model.dart';

abstract class SavingsLocalDataSource {
  Future<void> insertSaving(
    SavingModel savingModel,
    PendingOperationModel pendingOperationModel,
  );
  Future<void> updateSaving(
    SavingModel savingModel,
    PendingOperationModel pendingOperationModel,
  );
  Future<void> deleteSaving(
    String savingId,
    PendingOperationModel pendingOperationModel,
  );
  Future<SavingModel?> getSavingById(String savingId);
  Future<List<SavingModel>> getSavingsByGoalId(String goalId);
  Stream<List<SavingModel>> watchSavings();
  Future<void> syncRemoteSavings(List<SavingModel> savings);
}
