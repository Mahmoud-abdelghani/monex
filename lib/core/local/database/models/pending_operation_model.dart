import 'package:monex/core/local/database/enums/sync_enums.dart';

class PendingOperationModel {
  final String operationId;
  final String entityId;
  final EntityType entityType;
  final Operation operation;
  final OperationStatus status;
  final int retryCount;
  final DateTime? lastAttemptedAt;
  final DateTime createdAt;

  PendingOperationModel({
    required this.operationId,
    required this.entityId,
    required this.entityType,
    required this.operation,
    required this.status,
    required this.retryCount,
    required this.lastAttemptedAt,
    required this.createdAt,
  });
}