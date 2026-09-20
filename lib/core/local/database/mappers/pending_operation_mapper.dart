import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/models/pending_operation_model.dart';

extension PendingOperationLocalMapper on PendingOperationModel {
  PendingOperationsTableCompanion toCompanion() {
    return PendingOperationsTableCompanion(
      operationId: Value(operationId),
      entityId: Value(entityId),
      entityType: Value(entityType),
      operationType: Value(operation),
      status: Value(status),
      retryCount: Value(retryCount),
      lastAttemptedAt: Value(lastAttemptedAt),
      createdAt: Value(createdAt),
    );
  }
}

extension PendingOperationsTableDataMapper on PendingOperationsTableData {
  PendingOperationModel toModel() {
    return PendingOperationModel(
      operationId: operationId,
      entityId: entityId,
      entityType: entityType,
      operation: operationType,
      status: status,
      retryCount: retryCount,
      lastAttemptedAt: lastAttemptedAt,
      createdAt: createdAt,
    );
  }
}
