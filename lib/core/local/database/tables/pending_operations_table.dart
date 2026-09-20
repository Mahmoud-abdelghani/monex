import 'package:drift/drift.dart';
import 'package:monex/core/local/database/converters/sync_enum_converter.dart';

class PendingOperationsTable extends Table {
  TextColumn get operationId => text()();
  TextColumn get entityId => text()();
  IntColumn get operationType => integer().map(const OperationConverter())();
  IntColumn get entityType => integer().map(const EntityTypeConverter())();
  IntColumn get status => integer().map(const OperationStatusConverter())();
  IntColumn get retryCount => integer()();
  DateTimeColumn get lastAttemptedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {operationId};
}
