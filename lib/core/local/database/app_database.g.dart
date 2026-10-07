// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final String id;
  final String name;
  final String icon;
  const CategoriesTableData({
    required this.id,
    required this.name,
    required this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
    );
  }

  factory CategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
    };
  }

  CategoriesTableData copyWith({String? id, String? name, String? icon}) =>
      CategoriesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
      );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    required String icon,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon);
  static Insertable<CategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? rowid,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomesCategoriesTableTable extends IncomesCategoriesTable
    with TableInfo<$IncomesCategoriesTableTable, IncomesCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes_categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomesCategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomesCategoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomesCategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
    );
  }

  @override
  $IncomesCategoriesTableTable createAlias(String alias) {
    return $IncomesCategoriesTableTable(attachedDatabase, alias);
  }
}

class IncomesCategoriesTableData extends DataClass
    implements Insertable<IncomesCategoriesTableData> {
  final String id;
  final String name;
  final String icon;
  const IncomesCategoriesTableData({
    required this.id,
    required this.name,
    required this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    return map;
  }

  IncomesCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return IncomesCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
    );
  }

  factory IncomesCategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomesCategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
    };
  }

  IncomesCategoriesTableData copyWith({
    String? id,
    String? name,
    String? icon,
  }) => IncomesCategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
  );
  IncomesCategoriesTableData copyWithCompanion(
    IncomesCategoriesTableCompanion data,
  ) {
    return IncomesCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomesCategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon);
}

class IncomesCategoriesTableCompanion
    extends UpdateCompanion<IncomesCategoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> rowid;
  const IncomesCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesCategoriesTableCompanion.insert({
    required String id,
    required String name,
    required String icon,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon);
  static Insertable<IncomesCategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesCategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? rowid,
  }) {
    return IncomesCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    categoryId,
    title,
    amount,
    method,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpensesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableData extends DataClass
    implements Insertable<ExpensesTableData> {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final double amount;
  final String method;
  final DateTime date;
  const ExpensesTableData({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.method,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['category_id'] = Variable<String>(categoryId);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['method'] = Variable<String>(method);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      categoryId: Value(categoryId),
      title: Value(title),
      amount: Value(amount),
      method: Value(method),
      date: Value(date),
    );
  }

  factory ExpensesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      method: serializer.fromJson<String>(json['method']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'categoryId': serializer.toJson<String>(categoryId),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'method': serializer.toJson<String>(method),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  ExpensesTableData copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? title,
    double? amount,
    String? method,
    DateTime? date,
  }) => ExpensesTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    categoryId: categoryId ?? this.categoryId,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    method: method ?? this.method,
    date: date ?? this.date,
  );
  ExpensesTableData copyWithCompanion(ExpensesTableCompanion data) {
    return ExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      method: data.method.present ? data.method.value : this.method,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, categoryId, title, amount, method, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.method == this.method &&
          other.date == this.date);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> categoryId;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> method;
  final Value<DateTime> date;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String userId,
    required String categoryId,
    required String title,
    required double amount,
    required String method,
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       categoryId = Value(categoryId),
       title = Value(title),
       amount = Value(amount),
       method = Value(method),
       date = Value(date);
  static Insertable<ExpensesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? categoryId,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? method,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (method != null) 'method': method,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? categoryId,
    Value<String>? title,
    Value<double>? amount,
    Value<String>? method,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingOperationsTableTable extends PendingOperationsTable
    with TableInfo<$PendingOperationsTableTable, PendingOperationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOperationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _operationIdMeta = const VerificationMeta(
    'operationId',
  );
  @override
  late final GeneratedColumn<String> operationId = GeneratedColumn<String>(
    'operation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Operation, int> operationType =
      GeneratedColumn<int>(
        'operation_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Operation>(
        $PendingOperationsTableTable.$converteroperationType,
      );
  @override
  late final GeneratedColumnWithTypeConverter<EntityType, int> entityType =
      GeneratedColumn<int>(
        'entity_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<EntityType>(
        $PendingOperationsTableTable.$converterentityType,
      );
  @override
  late final GeneratedColumnWithTypeConverter<OperationStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OperationStatus>(
        $PendingOperationsTableTable.$converterstatus,
      );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttemptedAtMeta = const VerificationMeta(
    'lastAttemptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptedAt =
      GeneratedColumn<DateTime>(
        'last_attempted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    operationId,
    entityId,
    operationType,
    entityType,
    status,
    retryCount,
    lastAttemptedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_operations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingOperationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('operation_id')) {
      context.handle(
        _operationIdMeta,
        operationId.isAcceptableOrUnknown(
          data['operation_id']!,
          _operationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    } else if (isInserting) {
      context.missing(_retryCountMeta);
    }
    if (data.containsKey('last_attempted_at')) {
      context.handle(
        _lastAttemptedAtMeta,
        lastAttemptedAt.isAcceptableOrUnknown(
          data['last_attempted_at']!,
          _lastAttemptedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {operationId};
  @override
  PendingOperationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOperationsTableData(
      operationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_id'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operationType: $PendingOperationsTableTable.$converteroperationType
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}operation_type'],
            )!,
          ),
      entityType: $PendingOperationsTableTable.$converterentityType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}entity_type'],
        )!,
      ),
      status: $PendingOperationsTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastAttemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempted_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PendingOperationsTableTable createAlias(String alias) {
    return $PendingOperationsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Operation, int> $converteroperationType =
      const OperationConverter();
  static TypeConverter<EntityType, int> $converterentityType =
      const EntityTypeConverter();
  static TypeConverter<OperationStatus, int> $converterstatus =
      const OperationStatusConverter();
}

class PendingOperationsTableData extends DataClass
    implements Insertable<PendingOperationsTableData> {
  final String operationId;
  final String entityId;
  final Operation operationType;
  final EntityType entityType;
  final OperationStatus status;
  final int retryCount;
  final DateTime? lastAttemptedAt;
  final DateTime createdAt;
  const PendingOperationsTableData({
    required this.operationId,
    required this.entityId,
    required this.operationType,
    required this.entityType,
    required this.status,
    required this.retryCount,
    this.lastAttemptedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['operation_id'] = Variable<String>(operationId);
    map['entity_id'] = Variable<String>(entityId);
    {
      map['operation_type'] = Variable<int>(
        $PendingOperationsTableTable.$converteroperationType.toSql(
          operationType,
        ),
      );
    }
    {
      map['entity_type'] = Variable<int>(
        $PendingOperationsTableTable.$converterentityType.toSql(entityType),
      );
    }
    {
      map['status'] = Variable<int>(
        $PendingOperationsTableTable.$converterstatus.toSql(status),
      );
    }
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastAttemptedAt != null) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingOperationsTableCompanion toCompanion(bool nullToAbsent) {
    return PendingOperationsTableCompanion(
      operationId: Value(operationId),
      entityId: Value(entityId),
      operationType: Value(operationType),
      entityType: Value(entityType),
      status: Value(status),
      retryCount: Value(retryCount),
      lastAttemptedAt: lastAttemptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptedAt),
      createdAt: Value(createdAt),
    );
  }

  factory PendingOperationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOperationsTableData(
      operationId: serializer.fromJson<String>(json['operationId']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operationType: serializer.fromJson<Operation>(json['operationType']),
      entityType: serializer.fromJson<EntityType>(json['entityType']),
      status: serializer.fromJson<OperationStatus>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastAttemptedAt: serializer.fromJson<DateTime?>(json['lastAttemptedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'operationId': serializer.toJson<String>(operationId),
      'entityId': serializer.toJson<String>(entityId),
      'operationType': serializer.toJson<Operation>(operationType),
      'entityType': serializer.toJson<EntityType>(entityType),
      'status': serializer.toJson<OperationStatus>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastAttemptedAt': serializer.toJson<DateTime?>(lastAttemptedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingOperationsTableData copyWith({
    String? operationId,
    String? entityId,
    Operation? operationType,
    EntityType? entityType,
    OperationStatus? status,
    int? retryCount,
    Value<DateTime?> lastAttemptedAt = const Value.absent(),
    DateTime? createdAt,
  }) => PendingOperationsTableData(
    operationId: operationId ?? this.operationId,
    entityId: entityId ?? this.entityId,
    operationType: operationType ?? this.operationType,
    entityType: entityType ?? this.entityType,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastAttemptedAt: lastAttemptedAt.present
        ? lastAttemptedAt.value
        : this.lastAttemptedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  PendingOperationsTableData copyWithCompanion(
    PendingOperationsTableCompanion data,
  ) {
    return PendingOperationsTableData(
      operationId: data.operationId.present
          ? data.operationId.value
          : this.operationId,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastAttemptedAt: data.lastAttemptedAt.present
          ? data.lastAttemptedAt.value
          : this.lastAttemptedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationsTableData(')
          ..write('operationId: $operationId, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptedAt: $lastAttemptedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    operationId,
    entityId,
    operationType,
    entityType,
    status,
    retryCount,
    lastAttemptedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOperationsTableData &&
          other.operationId == this.operationId &&
          other.entityId == this.entityId &&
          other.operationType == this.operationType &&
          other.entityType == this.entityType &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastAttemptedAt == this.lastAttemptedAt &&
          other.createdAt == this.createdAt);
}

class PendingOperationsTableCompanion
    extends UpdateCompanion<PendingOperationsTableData> {
  final Value<String> operationId;
  final Value<String> entityId;
  final Value<Operation> operationType;
  final Value<EntityType> entityType;
  final Value<OperationStatus> status;
  final Value<int> retryCount;
  final Value<DateTime?> lastAttemptedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PendingOperationsTableCompanion({
    this.operationId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operationType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastAttemptedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingOperationsTableCompanion.insert({
    required String operationId,
    required String entityId,
    required Operation operationType,
    required EntityType entityType,
    required OperationStatus status,
    required int retryCount,
    this.lastAttemptedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : operationId = Value(operationId),
       entityId = Value(entityId),
       operationType = Value(operationType),
       entityType = Value(entityType),
       status = Value(status),
       retryCount = Value(retryCount);
  static Insertable<PendingOperationsTableData> custom({
    Expression<String>? operationId,
    Expression<String>? entityId,
    Expression<int>? operationType,
    Expression<int>? entityType,
    Expression<int>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? lastAttemptedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (operationId != null) 'operation_id': operationId,
      if (entityId != null) 'entity_id': entityId,
      if (operationType != null) 'operation_type': operationType,
      if (entityType != null) 'entity_type': entityType,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastAttemptedAt != null) 'last_attempted_at': lastAttemptedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingOperationsTableCompanion copyWith({
    Value<String>? operationId,
    Value<String>? entityId,
    Value<Operation>? operationType,
    Value<EntityType>? entityType,
    Value<OperationStatus>? status,
    Value<int>? retryCount,
    Value<DateTime?>? lastAttemptedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PendingOperationsTableCompanion(
      operationId: operationId ?? this.operationId,
      entityId: entityId ?? this.entityId,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (operationId.present) {
      map['operation_id'] = Variable<String>(operationId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<int>(
        $PendingOperationsTableTable.$converteroperationType.toSql(
          operationType.value,
        ),
      );
    }
    if (entityType.present) {
      map['entity_type'] = Variable<int>(
        $PendingOperationsTableTable.$converterentityType.toSql(
          entityType.value,
        ),
      );
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $PendingOperationsTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastAttemptedAt.present) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationsTableCompanion(')
          ..write('operationId: $operationId, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptedAt: $lastAttemptedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomesTableTable extends IncomesTable
    with TableInfo<$IncomesTableTable, IncomesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    categoryId,
    title,
    amount,
    method,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $IncomesTableTable createAlias(String alias) {
    return $IncomesTableTable(attachedDatabase, alias);
  }
}

class IncomesTableData extends DataClass
    implements Insertable<IncomesTableData> {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final double amount;
  final String method;
  final DateTime date;
  const IncomesTableData({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.method,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['category_id'] = Variable<String>(categoryId);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['method'] = Variable<String>(method);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  IncomesTableCompanion toCompanion(bool nullToAbsent) {
    return IncomesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      categoryId: Value(categoryId),
      title: Value(title),
      amount: Value(amount),
      method: Value(method),
      date: Value(date),
    );
  }

  factory IncomesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      method: serializer.fromJson<String>(json['method']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'categoryId': serializer.toJson<String>(categoryId),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'method': serializer.toJson<String>(method),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  IncomesTableData copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? title,
    double? amount,
    String? method,
    DateTime? date,
  }) => IncomesTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    categoryId: categoryId ?? this.categoryId,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    method: method ?? this.method,
    date: date ?? this.date,
  );
  IncomesTableData copyWithCompanion(IncomesTableCompanion data) {
    return IncomesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      method: data.method.present ? data.method.value : this.method,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, categoryId, title, amount, method, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.method == this.method &&
          other.date == this.date);
}

class IncomesTableCompanion extends UpdateCompanion<IncomesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> categoryId;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> method;
  final Value<DateTime> date;
  final Value<int> rowid;
  const IncomesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesTableCompanion.insert({
    required String id,
    required String userId,
    required String categoryId,
    required String title,
    required double amount,
    required String method,
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       categoryId = Value(categoryId),
       title = Value(title),
       amount = Value(amount),
       method = Value(method),
       date = Value(date);
  static Insertable<IncomesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? categoryId,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? method,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (method != null) 'method': method,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? categoryId,
    Value<String>? title,
    Value<double>? amount,
    Value<String>? method,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return IncomesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTableTable extends GoalsTable
    with TableInfo<$GoalsTableTable, GoalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMeta = const VerificationMeta(
    'targetAmount',
  );
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
    'target_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<GoalStatus>($GoalsTableTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<ContributionPeriod, int>
  contributionPeriod =
      GeneratedColumn<int>(
        'contribution_period',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ContributionPeriod>(
        $GoalsTableTable.$convertercontributionPeriod,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    targetAmount,
    deadline,
    status,
    contributionPeriod,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
        _targetAmountMeta,
        targetAmount.isAcceptableOrUnknown(
          data['target_amount']!,
          _targetAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_amount'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      status: $GoalsTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      contributionPeriod: $GoalsTableTable.$convertercontributionPeriod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}contribution_period'],
        )!,
      ),
    );
  }

  @override
  $GoalsTableTable createAlias(String alias) {
    return $GoalsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<GoalStatus, int> $converterstatus =
      const GoalStatusConverter();
  static TypeConverter<ContributionPeriod, int> $convertercontributionPeriod =
      const ContributionPeriodConverter();
}

class GoalsTableData extends DataClass implements Insertable<GoalsTableData> {
  final String id;
  final String title;
  final double targetAmount;
  final DateTime deadline;
  final GoalStatus status;
  final ContributionPeriod contributionPeriod;
  const GoalsTableData({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.deadline,
    required this.status,
    required this.contributionPeriod,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['target_amount'] = Variable<double>(targetAmount);
    map['deadline'] = Variable<DateTime>(deadline);
    {
      map['status'] = Variable<int>(
        $GoalsTableTable.$converterstatus.toSql(status),
      );
    }
    {
      map['contribution_period'] = Variable<int>(
        $GoalsTableTable.$convertercontributionPeriod.toSql(contributionPeriod),
      );
    }
    return map;
  }

  GoalsTableCompanion toCompanion(bool nullToAbsent) {
    return GoalsTableCompanion(
      id: Value(id),
      title: Value(title),
      targetAmount: Value(targetAmount),
      deadline: Value(deadline),
      status: Value(status),
      contributionPeriod: Value(contributionPeriod),
    );
  }

  factory GoalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      status: serializer.fromJson<GoalStatus>(json['status']),
      contributionPeriod: serializer.fromJson<ContributionPeriod>(
        json['contributionPeriod'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'deadline': serializer.toJson<DateTime>(deadline),
      'status': serializer.toJson<GoalStatus>(status),
      'contributionPeriod': serializer.toJson<ContributionPeriod>(
        contributionPeriod,
      ),
    };
  }

  GoalsTableData copyWith({
    String? id,
    String? title,
    double? targetAmount,
    DateTime? deadline,
    GoalStatus? status,
    ContributionPeriod? contributionPeriod,
  }) => GoalsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    targetAmount: targetAmount ?? this.targetAmount,
    deadline: deadline ?? this.deadline,
    status: status ?? this.status,
    contributionPeriod: contributionPeriod ?? this.contributionPeriod,
  );
  GoalsTableData copyWithCompanion(GoalsTableCompanion data) {
    return GoalsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      status: data.status.present ? data.status.value : this.status,
      contributionPeriod: data.contributionPeriod.present
          ? data.contributionPeriod.value
          : this.contributionPeriod,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('contributionPeriod: $contributionPeriod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    targetAmount,
    deadline,
    status,
    contributionPeriod,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetAmount == this.targetAmount &&
          other.deadline == this.deadline &&
          other.status == this.status &&
          other.contributionPeriod == this.contributionPeriod);
}

class GoalsTableCompanion extends UpdateCompanion<GoalsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> targetAmount;
  final Value<DateTime> deadline;
  final Value<GoalStatus> status;
  final Value<ContributionPeriod> contributionPeriod;
  final Value<int> rowid;
  const GoalsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.deadline = const Value.absent(),
    this.status = const Value.absent(),
    this.contributionPeriod = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsTableCompanion.insert({
    required String id,
    required String title,
    required double targetAmount,
    required DateTime deadline,
    required GoalStatus status,
    required ContributionPeriod contributionPeriod,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       targetAmount = Value(targetAmount),
       deadline = Value(deadline),
       status = Value(status),
       contributionPeriod = Value(contributionPeriod);
  static Insertable<GoalsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? targetAmount,
    Expression<DateTime>? deadline,
    Expression<int>? status,
    Expression<int>? contributionPeriod,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (deadline != null) 'deadline': deadline,
      if (status != null) 'status': status,
      if (contributionPeriod != null) 'contribution_period': contributionPeriod,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<double>? targetAmount,
    Value<DateTime>? deadline,
    Value<GoalStatus>? status,
    Value<ContributionPeriod>? contributionPeriod,
    Value<int>? rowid,
  }) {
    return GoalsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetAmount: targetAmount ?? this.targetAmount,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      contributionPeriod: contributionPeriod ?? this.contributionPeriod,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $GoalsTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (contributionPeriod.present) {
      map['contribution_period'] = Variable<int>(
        $GoalsTableTable.$convertercontributionPeriod.toSql(
          contributionPeriod.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('contributionPeriod: $contributionPeriod, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsTableTable extends SavingsTable
    with TableInfo<$SavingsTableTable, SavingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, goalId, amount, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $SavingsTableTable createAlias(String alias) {
    return $SavingsTableTable(attachedDatabase, alias);
  }
}

class SavingsTableData extends DataClass
    implements Insertable<SavingsTableData> {
  final String id;
  final String goalId;
  final double amount;
  final DateTime date;
  const SavingsTableData({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  SavingsTableCompanion toCompanion(bool nullToAbsent) {
    return SavingsTableCompanion(
      id: Value(id),
      goalId: Value(goalId),
      amount: Value(amount),
      date: Value(date),
    );
  }

  factory SavingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsTableData(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  SavingsTableData copyWith({
    String? id,
    String? goalId,
    double? amount,
    DateTime? date,
  }) => SavingsTableData(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
  );
  SavingsTableData copyWithCompanion(SavingsTableCompanion data) {
    return SavingsTableData(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsTableData(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, goalId, amount, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsTableData &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.amount == this.amount &&
          other.date == this.date);
}

class SavingsTableCompanion extends UpdateCompanion<SavingsTableData> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<int> rowid;
  const SavingsTableCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsTableCompanion.insert({
    required String id,
    required String goalId,
    required double amount,
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       amount = Value(amount),
       date = Value(date);
  static Insertable<SavingsTableData> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return SavingsTableCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsTableCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetTableTable extends BudgetTable
    with TableInfo<$BudgetTableTable, BudgetTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $BudgetTableTable createAlias(String alias) {
    return $BudgetTableTable(attachedDatabase, alias);
  }
}

class BudgetTableData extends DataClass implements Insertable<BudgetTableData> {
  final String id;
  final double amount;
  const BudgetTableData({required this.id, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  BudgetTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetTableCompanion(id: Value(id), amount: Value(amount));
  }

  factory BudgetTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetTableData(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
    };
  }

  BudgetTableData copyWith({String? id, double? amount}) =>
      BudgetTableData(id: id ?? this.id, amount: amount ?? this.amount);
  BudgetTableData copyWithCompanion(BudgetTableCompanion data) {
    return BudgetTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetTableData &&
          other.id == this.id &&
          other.amount == this.amount);
}

class BudgetTableCompanion extends UpdateCompanion<BudgetTableData> {
  final Value<String> id;
  final Value<double> amount;
  final Value<int> rowid;
  const BudgetTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetTableCompanion.insert({
    required String id,
    required double amount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount);
  static Insertable<BudgetTableData> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetTableCompanion copyWith({
    Value<String>? id,
    Value<double>? amount,
    Value<int>? rowid,
  }) {
    return BudgetTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTableTable extends RemindersTable
    with TableInfo<$RemindersTableTable, RemindersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContributionPeriod, int>
  frequency = GeneratedColumn<int>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<ContributionPeriod>($RemindersTableTable.$converterfrequency);
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleDateMeta = const VerificationMeta(
    'scheduleDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduleDate = GeneratedColumn<DateTime>(
    'schedule_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amount,
    frequency,
    deadline,
    scheduleDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemindersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('schedule_date')) {
      context.handle(
        _scheduleDateMeta,
        scheduleDate.isAcceptableOrUnknown(
          data['schedule_date']!,
          _scheduleDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemindersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemindersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      frequency: $RemindersTableTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      scheduleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}schedule_date'],
      )!,
    );
  }

  @override
  $RemindersTableTable createAlias(String alias) {
    return $RemindersTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ContributionPeriod, int> $converterfrequency =
      const ContributionPeriodConverter();
}

class RemindersTableData extends DataClass
    implements Insertable<RemindersTableData> {
  final String id;
  final String title;
  final double amount;
  final ContributionPeriod frequency;
  final DateTime deadline;
  final DateTime scheduleDate;
  const RemindersTableData({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.deadline,
    required this.scheduleDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    {
      map['frequency'] = Variable<int>(
        $RemindersTableTable.$converterfrequency.toSql(frequency),
      );
    }
    map['deadline'] = Variable<DateTime>(deadline);
    map['schedule_date'] = Variable<DateTime>(scheduleDate);
    return map;
  }

  RemindersTableCompanion toCompanion(bool nullToAbsent) {
    return RemindersTableCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      frequency: Value(frequency),
      deadline: Value(deadline),
      scheduleDate: Value(scheduleDate),
    );
  }

  factory RemindersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemindersTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      frequency: serializer.fromJson<ContributionPeriod>(json['frequency']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      scheduleDate: serializer.fromJson<DateTime>(json['scheduleDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'frequency': serializer.toJson<ContributionPeriod>(frequency),
      'deadline': serializer.toJson<DateTime>(deadline),
      'scheduleDate': serializer.toJson<DateTime>(scheduleDate),
    };
  }

  RemindersTableData copyWith({
    String? id,
    String? title,
    double? amount,
    ContributionPeriod? frequency,
    DateTime? deadline,
    DateTime? scheduleDate,
  }) => RemindersTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    frequency: frequency ?? this.frequency,
    deadline: deadline ?? this.deadline,
    scheduleDate: scheduleDate ?? this.scheduleDate,
  );
  RemindersTableData copyWithCompanion(RemindersTableCompanion data) {
    return RemindersTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      scheduleDate: data.scheduleDate.present
          ? data.scheduleDate.value
          : this.scheduleDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('deadline: $deadline, ')
          ..write('scheduleDate: $scheduleDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, amount, frequency, deadline, scheduleDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemindersTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.frequency == this.frequency &&
          other.deadline == this.deadline &&
          other.scheduleDate == this.scheduleDate);
}

class RemindersTableCompanion extends UpdateCompanion<RemindersTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<ContributionPeriod> frequency;
  final Value<DateTime> deadline;
  final Value<DateTime> scheduleDate;
  final Value<int> rowid;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.frequency = const Value.absent(),
    this.deadline = const Value.absent(),
    this.scheduleDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersTableCompanion.insert({
    required String id,
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
    required DateTime scheduleDate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       amount = Value(amount),
       frequency = Value(frequency),
       deadline = Value(deadline),
       scheduleDate = Value(scheduleDate);
  static Insertable<RemindersTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<int>? frequency,
    Expression<DateTime>? deadline,
    Expression<DateTime>? scheduleDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (frequency != null) 'frequency': frequency,
      if (deadline != null) 'deadline': deadline,
      if (scheduleDate != null) 'schedule_date': scheduleDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<double>? amount,
    Value<ContributionPeriod>? frequency,
    Value<DateTime>? deadline,
    Value<DateTime>? scheduleDate,
    Value<int>? rowid,
  }) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      deadline: deadline ?? this.deadline,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(
        $RemindersTableTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (scheduleDate.present) {
      map['schedule_date'] = Variable<DateTime>(scheduleDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('deadline: $deadline, ')
          ..write('scheduleDate: $scheduleDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $IncomesCategoriesTableTable incomesCategoriesTable =
      $IncomesCategoriesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $PendingOperationsTableTable pendingOperationsTable =
      $PendingOperationsTableTable(this);
  late final $IncomesTableTable incomesTable = $IncomesTableTable(this);
  late final $GoalsTableTable goalsTable = $GoalsTableTable(this);
  late final $SavingsTableTable savingsTable = $SavingsTableTable(this);
  late final $BudgetTableTable budgetTable = $BudgetTableTable(this);
  late final $RemindersTableTable remindersTable = $RemindersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesTable,
    incomesCategoriesTable,
    expensesTable,
    pendingOperationsTable,
    incomesTable,
    goalsTable,
    savingsTable,
    budgetTable,
    remindersTable,
  ];
}

typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      required String id,
      required String name,
      required String icon,
      Value<int> rowid,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> icon,
      Value<int> rowid,
    });

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (
            CategoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $CategoriesTableTable,
              CategoriesTableData
            >,
          ),
          CategoriesTableData,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (
        CategoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData
        >,
      ),
      CategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$IncomesCategoriesTableTableCreateCompanionBuilder =
    IncomesCategoriesTableCompanion Function({
      required String id,
      required String name,
      required String icon,
      Value<int> rowid,
    });
typedef $$IncomesCategoriesTableTableUpdateCompanionBuilder =
    IncomesCategoriesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> icon,
      Value<int> rowid,
    });

class $$IncomesCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesCategoriesTableTable> {
  $$IncomesCategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomesCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesCategoriesTableTable> {
  $$IncomesCategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomesCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesCategoriesTableTable> {
  $$IncomesCategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$IncomesCategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomesCategoriesTableTable,
          IncomesCategoriesTableData,
          $$IncomesCategoriesTableTableFilterComposer,
          $$IncomesCategoriesTableTableOrderingComposer,
          $$IncomesCategoriesTableTableAnnotationComposer,
          $$IncomesCategoriesTableTableCreateCompanionBuilder,
          $$IncomesCategoriesTableTableUpdateCompanionBuilder,
          (
            IncomesCategoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $IncomesCategoriesTableTable,
              IncomesCategoriesTableData
            >,
          ),
          IncomesCategoriesTableData,
          PrefetchHooks Function()
        > {
  $$IncomesCategoriesTableTableTableManager(
    _$AppDatabase db,
    $IncomesCategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesCategoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$IncomesCategoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IncomesCategoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomesCategoriesTableCompanion(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                Value<int> rowid = const Value.absent(),
              }) => IncomesCategoriesTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomesCategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomesCategoriesTableTable,
      IncomesCategoriesTableData,
      $$IncomesCategoriesTableTableFilterComposer,
      $$IncomesCategoriesTableTableOrderingComposer,
      $$IncomesCategoriesTableTableAnnotationComposer,
      $$IncomesCategoriesTableTableCreateCompanionBuilder,
      $$IncomesCategoriesTableTableUpdateCompanionBuilder,
      (
        IncomesCategoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $IncomesCategoriesTableTable,
          IncomesCategoriesTableData
        >,
      ),
      IncomesCategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableTableCreateCompanionBuilder =
    ExpensesTableCompanion Function({
      required String id,
      required String userId,
      required String categoryId,
      required String title,
      required double amount,
      required String method,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$ExpensesTableTableUpdateCompanionBuilder =
    ExpensesTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> categoryId,
      Value<String> title,
      Value<double> amount,
      Value<String> method,
      Value<DateTime> date,
      Value<int> rowid,
    });

class $$ExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$ExpensesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTableTable,
          ExpensesTableData,
          $$ExpensesTableTableFilterComposer,
          $$ExpensesTableTableOrderingComposer,
          $$ExpensesTableTableAnnotationComposer,
          $$ExpensesTableTableCreateCompanionBuilder,
          $$ExpensesTableTableUpdateCompanionBuilder,
          (
            ExpensesTableData,
            BaseReferences<
              _$AppDatabase,
              $ExpensesTableTable,
              ExpensesTableData
            >,
          ),
          ExpensesTableData,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion(
                id: id,
                userId: userId,
                categoryId: categoryId,
                title: title,
                amount: amount,
                method: method,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String categoryId,
                required String title,
                required double amount,
                required String method,
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion.insert(
                id: id,
                userId: userId,
                categoryId: categoryId,
                title: title,
                amount: amount,
                method: method,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTableTable,
      ExpensesTableData,
      $$ExpensesTableTableFilterComposer,
      $$ExpensesTableTableOrderingComposer,
      $$ExpensesTableTableAnnotationComposer,
      $$ExpensesTableTableCreateCompanionBuilder,
      $$ExpensesTableTableUpdateCompanionBuilder,
      (
        ExpensesTableData,
        BaseReferences<_$AppDatabase, $ExpensesTableTable, ExpensesTableData>,
      ),
      ExpensesTableData,
      PrefetchHooks Function()
    >;
typedef $$PendingOperationsTableTableCreateCompanionBuilder =
    PendingOperationsTableCompanion Function({
      required String operationId,
      required String entityId,
      required Operation operationType,
      required EntityType entityType,
      required OperationStatus status,
      required int retryCount,
      Value<DateTime?> lastAttemptedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PendingOperationsTableTableUpdateCompanionBuilder =
    PendingOperationsTableCompanion Function({
      Value<String> operationId,
      Value<String> entityId,
      Value<Operation> operationType,
      Value<EntityType> entityType,
      Value<OperationStatus> status,
      Value<int> retryCount,
      Value<DateTime?> lastAttemptedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PendingOperationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PendingOperationsTableTable> {
  $$PendingOperationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Operation, Operation, int> get operationType =>
      $composableBuilder(
        column: $table.operationType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<EntityType, EntityType, int> get entityType =>
      $composableBuilder(
        column: $table.entityType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<OperationStatus, OperationStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingOperationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingOperationsTableTable> {
  $$PendingOperationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingOperationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingOperationsTableTable> {
  $$PendingOperationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Operation, int> get operationType =>
      $composableBuilder(
        column: $table.operationType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<EntityType, int> get entityType =>
      $composableBuilder(
        column: $table.entityType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<OperationStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingOperationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingOperationsTableTable,
          PendingOperationsTableData,
          $$PendingOperationsTableTableFilterComposer,
          $$PendingOperationsTableTableOrderingComposer,
          $$PendingOperationsTableTableAnnotationComposer,
          $$PendingOperationsTableTableCreateCompanionBuilder,
          $$PendingOperationsTableTableUpdateCompanionBuilder,
          (
            PendingOperationsTableData,
            BaseReferences<
              _$AppDatabase,
              $PendingOperationsTableTable,
              PendingOperationsTableData
            >,
          ),
          PendingOperationsTableData,
          PrefetchHooks Function()
        > {
  $$PendingOperationsTableTableTableManager(
    _$AppDatabase db,
    $PendingOperationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingOperationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingOperationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingOperationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> operationId = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<Operation> operationType = const Value.absent(),
                Value<EntityType> entityType = const Value.absent(),
                Value<OperationStatus> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> lastAttemptedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingOperationsTableCompanion(
                operationId: operationId,
                entityId: entityId,
                operationType: operationType,
                entityType: entityType,
                status: status,
                retryCount: retryCount,
                lastAttemptedAt: lastAttemptedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String operationId,
                required String entityId,
                required Operation operationType,
                required EntityType entityType,
                required OperationStatus status,
                required int retryCount,
                Value<DateTime?> lastAttemptedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingOperationsTableCompanion.insert(
                operationId: operationId,
                entityId: entityId,
                operationType: operationType,
                entityType: entityType,
                status: status,
                retryCount: retryCount,
                lastAttemptedAt: lastAttemptedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingOperationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingOperationsTableTable,
      PendingOperationsTableData,
      $$PendingOperationsTableTableFilterComposer,
      $$PendingOperationsTableTableOrderingComposer,
      $$PendingOperationsTableTableAnnotationComposer,
      $$PendingOperationsTableTableCreateCompanionBuilder,
      $$PendingOperationsTableTableUpdateCompanionBuilder,
      (
        PendingOperationsTableData,
        BaseReferences<
          _$AppDatabase,
          $PendingOperationsTableTable,
          PendingOperationsTableData
        >,
      ),
      PendingOperationsTableData,
      PrefetchHooks Function()
    >;
typedef $$IncomesTableTableCreateCompanionBuilder =
    IncomesTableCompanion Function({
      required String id,
      required String userId,
      required String categoryId,
      required String title,
      required double amount,
      required String method,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$IncomesTableTableUpdateCompanionBuilder =
    IncomesTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> categoryId,
      Value<String> title,
      Value<double> amount,
      Value<String> method,
      Value<DateTime> date,
      Value<int> rowid,
    });

class $$IncomesTableTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesTableTable> {
  $$IncomesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesTableTable> {
  $$IncomesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesTableTable> {
  $$IncomesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$IncomesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomesTableTable,
          IncomesTableData,
          $$IncomesTableTableFilterComposer,
          $$IncomesTableTableOrderingComposer,
          $$IncomesTableTableAnnotationComposer,
          $$IncomesTableTableCreateCompanionBuilder,
          $$IncomesTableTableUpdateCompanionBuilder,
          (
            IncomesTableData,
            BaseReferences<_$AppDatabase, $IncomesTableTable, IncomesTableData>,
          ),
          IncomesTableData,
          PrefetchHooks Function()
        > {
  $$IncomesTableTableTableManager(_$AppDatabase db, $IncomesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomesTableCompanion(
                id: id,
                userId: userId,
                categoryId: categoryId,
                title: title,
                amount: amount,
                method: method,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String categoryId,
                required String title,
                required double amount,
                required String method,
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => IncomesTableCompanion.insert(
                id: id,
                userId: userId,
                categoryId: categoryId,
                title: title,
                amount: amount,
                method: method,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomesTableTable,
      IncomesTableData,
      $$IncomesTableTableFilterComposer,
      $$IncomesTableTableOrderingComposer,
      $$IncomesTableTableAnnotationComposer,
      $$IncomesTableTableCreateCompanionBuilder,
      $$IncomesTableTableUpdateCompanionBuilder,
      (
        IncomesTableData,
        BaseReferences<_$AppDatabase, $IncomesTableTable, IncomesTableData>,
      ),
      IncomesTableData,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableTableCreateCompanionBuilder =
    GoalsTableCompanion Function({
      required String id,
      required String title,
      required double targetAmount,
      required DateTime deadline,
      required GoalStatus status,
      required ContributionPeriod contributionPeriod,
      Value<int> rowid,
    });
typedef $$GoalsTableTableUpdateCompanionBuilder =
    GoalsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<double> targetAmount,
      Value<DateTime> deadline,
      Value<GoalStatus> status,
      Value<ContributionPeriod> contributionPeriod,
      Value<int> rowid,
    });

class $$GoalsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalStatus, GoalStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ContributionPeriod, ContributionPeriod, int>
  get contributionPeriod => $composableBuilder(
    column: $table.contributionPeriod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$GoalsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contributionPeriod => $composableBuilder(
    column: $table.contributionPeriod,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContributionPeriod, int>
  get contributionPeriod => $composableBuilder(
    column: $table.contributionPeriod,
    builder: (column) => column,
  );
}

class $$GoalsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTableTable,
          GoalsTableData,
          $$GoalsTableTableFilterComposer,
          $$GoalsTableTableOrderingComposer,
          $$GoalsTableTableAnnotationComposer,
          $$GoalsTableTableCreateCompanionBuilder,
          $$GoalsTableTableUpdateCompanionBuilder,
          (
            GoalsTableData,
            BaseReferences<_$AppDatabase, $GoalsTableTable, GoalsTableData>,
          ),
          GoalsTableData,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableTableManager(_$AppDatabase db, $GoalsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> targetAmount = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<GoalStatus> status = const Value.absent(),
                Value<ContributionPeriod> contributionPeriod =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsTableCompanion(
                id: id,
                title: title,
                targetAmount: targetAmount,
                deadline: deadline,
                status: status,
                contributionPeriod: contributionPeriod,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required double targetAmount,
                required DateTime deadline,
                required GoalStatus status,
                required ContributionPeriod contributionPeriod,
                Value<int> rowid = const Value.absent(),
              }) => GoalsTableCompanion.insert(
                id: id,
                title: title,
                targetAmount: targetAmount,
                deadline: deadline,
                status: status,
                contributionPeriod: contributionPeriod,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTableTable,
      GoalsTableData,
      $$GoalsTableTableFilterComposer,
      $$GoalsTableTableOrderingComposer,
      $$GoalsTableTableAnnotationComposer,
      $$GoalsTableTableCreateCompanionBuilder,
      $$GoalsTableTableUpdateCompanionBuilder,
      (
        GoalsTableData,
        BaseReferences<_$AppDatabase, $GoalsTableTable, GoalsTableData>,
      ),
      GoalsTableData,
      PrefetchHooks Function()
    >;
typedef $$SavingsTableTableCreateCompanionBuilder =
    SavingsTableCompanion Function({
      required String id,
      required String goalId,
      required double amount,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$SavingsTableTableUpdateCompanionBuilder =
    SavingsTableCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<double> amount,
      Value<DateTime> date,
      Value<int> rowid,
    });

class $$SavingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsTableTable> {
  $$SavingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsTableTable> {
  $$SavingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsTableTable> {
  $$SavingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$SavingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavingsTableTable,
          SavingsTableData,
          $$SavingsTableTableFilterComposer,
          $$SavingsTableTableOrderingComposer,
          $$SavingsTableTableAnnotationComposer,
          $$SavingsTableTableCreateCompanionBuilder,
          $$SavingsTableTableUpdateCompanionBuilder,
          (
            SavingsTableData,
            BaseReferences<_$AppDatabase, $SavingsTableTable, SavingsTableData>,
          ),
          SavingsTableData,
          PrefetchHooks Function()
        > {
  $$SavingsTableTableTableManager(_$AppDatabase db, $SavingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsTableCompanion(
                id: id,
                goalId: goalId,
                amount: amount,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required double amount,
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => SavingsTableCompanion.insert(
                id: id,
                goalId: goalId,
                amount: amount,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavingsTableTable,
      SavingsTableData,
      $$SavingsTableTableFilterComposer,
      $$SavingsTableTableOrderingComposer,
      $$SavingsTableTableAnnotationComposer,
      $$SavingsTableTableCreateCompanionBuilder,
      $$SavingsTableTableUpdateCompanionBuilder,
      (
        SavingsTableData,
        BaseReferences<_$AppDatabase, $SavingsTableTable, SavingsTableData>,
      ),
      SavingsTableData,
      PrefetchHooks Function()
    >;
typedef $$BudgetTableTableCreateCompanionBuilder =
    BudgetTableCompanion Function({
      required String id,
      required double amount,
      Value<int> rowid,
    });
typedef $$BudgetTableTableUpdateCompanionBuilder =
    BudgetTableCompanion Function({
      Value<String> id,
      Value<double> amount,
      Value<int> rowid,
    });

class $$BudgetTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$BudgetTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetTableTable,
          BudgetTableData,
          $$BudgetTableTableFilterComposer,
          $$BudgetTableTableOrderingComposer,
          $$BudgetTableTableAnnotationComposer,
          $$BudgetTableTableCreateCompanionBuilder,
          $$BudgetTableTableUpdateCompanionBuilder,
          (
            BudgetTableData,
            BaseReferences<_$AppDatabase, $BudgetTableTable, BudgetTableData>,
          ),
          BudgetTableData,
          PrefetchHooks Function()
        > {
  $$BudgetTableTableTableManager(_$AppDatabase db, $BudgetTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetTableCompanion(id: id, amount: amount, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required double amount,
                Value<int> rowid = const Value.absent(),
              }) => BudgetTableCompanion.insert(
                id: id,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetTableTable,
      BudgetTableData,
      $$BudgetTableTableFilterComposer,
      $$BudgetTableTableOrderingComposer,
      $$BudgetTableTableAnnotationComposer,
      $$BudgetTableTableCreateCompanionBuilder,
      $$BudgetTableTableUpdateCompanionBuilder,
      (
        BudgetTableData,
        BaseReferences<_$AppDatabase, $BudgetTableTable, BudgetTableData>,
      ),
      BudgetTableData,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableTableCreateCompanionBuilder =
    RemindersTableCompanion Function({
      required String id,
      required String title,
      required double amount,
      required ContributionPeriod frequency,
      required DateTime deadline,
      required DateTime scheduleDate,
      Value<int> rowid,
    });
typedef $$RemindersTableTableUpdateCompanionBuilder =
    RemindersTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<double> amount,
      Value<ContributionPeriod> frequency,
      Value<DateTime> deadline,
      Value<DateTime> scheduleDate,
      Value<int> rowid,
    });

class $$RemindersTableTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ContributionPeriod, ContributionPeriod, int>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContributionPeriod, int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduleDate => $composableBuilder(
    column: $table.scheduleDate,
    builder: (column) => column,
  );
}

class $$RemindersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTableTable,
          RemindersTableData,
          $$RemindersTableTableFilterComposer,
          $$RemindersTableTableOrderingComposer,
          $$RemindersTableTableAnnotationComposer,
          $$RemindersTableTableCreateCompanionBuilder,
          $$RemindersTableTableUpdateCompanionBuilder,
          (
            RemindersTableData,
            BaseReferences<
              _$AppDatabase,
              $RemindersTableTable,
              RemindersTableData
            >,
          ),
          RemindersTableData,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableTableManager(
    _$AppDatabase db,
    $RemindersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<ContributionPeriod> frequency = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<DateTime> scheduleDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion(
                id: id,
                title: title,
                amount: amount,
                frequency: frequency,
                deadline: deadline,
                scheduleDate: scheduleDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required double amount,
                required ContributionPeriod frequency,
                required DateTime deadline,
                required DateTime scheduleDate,
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion.insert(
                id: id,
                title: title,
                amount: amount,
                frequency: frequency,
                deadline: deadline,
                scheduleDate: scheduleDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTableTable,
      RemindersTableData,
      $$RemindersTableTableFilterComposer,
      $$RemindersTableTableOrderingComposer,
      $$RemindersTableTableAnnotationComposer,
      $$RemindersTableTableCreateCompanionBuilder,
      $$RemindersTableTableUpdateCompanionBuilder,
      (
        RemindersTableData,
        BaseReferences<_$AppDatabase, $RemindersTableTable, RemindersTableData>,
      ),
      RemindersTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$IncomesCategoriesTableTableTableManager get incomesCategoriesTable =>
      $$IncomesCategoriesTableTableTableManager(
        _db,
        _db.incomesCategoriesTable,
      );
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
  $$PendingOperationsTableTableTableManager get pendingOperationsTable =>
      $$PendingOperationsTableTableTableManager(
        _db,
        _db.pendingOperationsTable,
      );
  $$IncomesTableTableTableManager get incomesTable =>
      $$IncomesTableTableTableManager(_db, _db.incomesTable);
  $$GoalsTableTableTableManager get goalsTable =>
      $$GoalsTableTableTableManager(_db, _db.goalsTable);
  $$SavingsTableTableTableManager get savingsTable =>
      $$SavingsTableTableTableManager(_db, _db.savingsTable);
  $$BudgetTableTableTableManager get budgetTable =>
      $$BudgetTableTableTableManager(_db, _db.budgetTable);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(_db, _db.remindersTable);
}
