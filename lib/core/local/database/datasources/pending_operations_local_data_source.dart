import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';

abstract class PendingOperationsLocalDataSource {
  Future<void> insert(PendingOperationModel data);

  Future<List<PendingOperationModel>> getPendingOperations();

  Future<bool> updateStatus(String operationId, OperationStatus status);

  Future<int> deleteOperation(String operationId);

  Future<bool> hasPendingOperation(String entityId);

  Future<bool> recordRetry(String operationId);
  Future<bool> resetRetry(String operationId);
}
