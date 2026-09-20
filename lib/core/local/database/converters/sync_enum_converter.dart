import 'package:drift/drift.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';

class OperationConverter extends TypeConverter<Operation, int> {
  const OperationConverter();

  @override
  Operation fromSql(int fromDb) {
    return Operation.values[fromDb];
  }

  @override
  int toSql(Operation value) {
    return value.index;
  }
}

class EntityTypeConverter extends TypeConverter<EntityType, int> {
  const EntityTypeConverter();

  @override
  EntityType fromSql(int fromDb) {
    return EntityType.values[fromDb];
  }

  @override
  int toSql(EntityType value) {
    return value.index;
  }
}

class OperationStatusConverter extends TypeConverter<OperationStatus, int> {
  const OperationStatusConverter();

  @override
  OperationStatus fromSql(int fromDb) {
    return OperationStatus.values[fromDb];
  }

  @override
  int toSql(OperationStatus value) {
    return value.index;
  }
}
