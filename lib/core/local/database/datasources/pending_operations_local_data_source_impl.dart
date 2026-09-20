import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/mappers/pending_operation_mapper.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';

class PendingOperationsLocalDataSourceImpl
    implements PendingOperationsLocalDataSource {
  final PendingOperationsDao dao;
  PendingOperationsLocalDataSourceImpl(this.dao);

  @override
  Future<int> deleteOperation(String operationId) {
    return dao.deleteOperation(operationId);
  }

  @override
  Future<List<PendingOperationModel>> getPendingOperations() {
    return dao.getPendingOperations().then(
      (data) => data.map((e) => e.toModel()).toList(),
    );
  }

  @override
  Future<void> insert(PendingOperationModel data) {
    return dao.insertPendingOperation(data.toCompanion());
  }

  @override
  Future<bool> updateStatus(String operationId, OperationStatus status) {
    return dao.updateStatus(operationId, status);
  }

  @override
  Future<bool> hasPendingOperation(String entityId) {
    return dao.hasPendingOperation(entityId);
  }

  @override
  Future<bool> recordRetry(String operationId) {
    return dao.recordRetry(operationId);
  }

  @override
  Future<bool> resetRetry(String operationId) {
    return dao.resetRetry(operationId);
  }
}
