import 'package:drift/drift.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/tables/pending_operations_table.dart';
import 'package:monex/features/expense/data/models/expense_model.dart';

part 'pending_operations_dao.g.dart';

@DriftAccessor(tables: [PendingOperationsTable])
class PendingOperationsDao extends DatabaseAccessor<AppDatabase>
    with _$PendingOperationsDaoMixin {
  PendingOperationsDao(super.db);

  Future<void> insertPendingOperation(PendingOperationsTableCompanion data) {
    return into(pendingOperationsTable).insert(data);
  }

  Future<bool> updateStatus(String operationId, OperationStatus status) {
    return (update(pendingOperationsTable)
          ..where((tbl) => tbl.operationId.equals(operationId)))
        .write(PendingOperationsTableCompanion(status: Value(status)))
        .then((rows) => rows > 0);
  }

  Future<List<PendingOperationsTableData>> getPendingOperations() {
    return select(pendingOperationsTable).get();
  }

  Future<int> deleteOperation(String operationId) {
    return (delete(
      pendingOperationsTable,
    )..where((tbl) => tbl.operationId.equals(operationId))).go();
  }

  Future<bool> hasPendingOperation(String entityId) async {
    return (select(pendingOperationsTable)
          ..where((tbl) => tbl.entityId.equals(entityId)))
        .getSingleOrNull()
        .then((operation) => operation != null);
  }

  Future<void> updatePendingOperation(
    String operationId,
    ExpenseModel expense,
  ) {
    return (update(pendingOperationsTable)
          ..where((tbl) => tbl.operationId.equals(operationId)))
        .write(PendingOperationsTableCompanion(entityId: Value(expense.id)))
        .then((rows) => rows > 0);
  }

  Future<bool> recordRetry(String operationId) async {
    final operation = await (select(
      pendingOperationsTable,
    )..where((tbl) => tbl.operationId.equals(operationId))).getSingleOrNull();

    if (operation == null) {
      return false;
    }
    return (update(pendingOperationsTable)
          ..where((tbl) => tbl.operationId.equals(operationId)))
        .write(
          PendingOperationsTableCompanion(
            retryCount: Value(operation.retryCount + 1),
            lastAttemptedAt: Value(DateTime.now()),
            status: const Value(OperationStatus.failed),
          ),
        )
        .then((rows) => rows > 0);
  }

  Future<bool> resetRetry (String operationId){
    return (update(pendingOperationsTable)
          ..where((tbl) => tbl.operationId.equals(operationId)))
        .write(
          PendingOperationsTableCompanion(
            retryCount: const Value(0),
            lastAttemptedAt: const Value(null),
            status: const Value(OperationStatus.pending),
          ),
        )
        .then((rows) => rows > 0);
  }
}
