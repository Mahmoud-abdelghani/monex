import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:monex/core/local/database/tables/categories_table.dart';
import 'package:monex/core/local/database/tables/expenses_table.dart';
import 'package:monex/core/local/database/tables/incomes_categories_table.dart';
import 'package:monex/core/local/database/tables/incomes_table.dart';
import 'package:monex/core/local/database/tables/pending_operations_table.dart';
import 'package:monex/core/local/database/enums/sync_enums.dart';
import 'package:monex/core/local/database/converters/sync_enum_converter.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CategoriesTable,
    IncomesCategoriesTable,
    ExpensesTable,
    PendingOperationsTable,
    IncomesTable
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'monex.db'));

  @override
  int get schemaVersion => 1;
}
