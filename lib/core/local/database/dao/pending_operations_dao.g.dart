// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operations_dao.dart';

// ignore_for_file: type=lint
mixin _$PendingOperationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PendingOperationsTableTable get pendingOperationsTable =>
      attachedDatabase.pendingOperationsTable;
  PendingOperationsDaoManager get managers => PendingOperationsDaoManager(this);
}

class PendingOperationsDaoManager {
  final _$PendingOperationsDaoMixin _db;
  PendingOperationsDaoManager(this._db);
  $$PendingOperationsTableTableTableManager get pendingOperationsTable =>
      $$PendingOperationsTableTableTableManager(
        _db.attachedDatabase,
        _db.pendingOperationsTable,
      );
}
