import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/expenses_dao.dart';
import 'package:monex/core/local/database/dao/incomes_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source_impl.dart';
import 'package:monex/core/services/connectivity_service.dart';
import 'package:monex/core/services/connectivity_service_impl.dart';
import 'package:monex/core/services/secure_storage.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:monex/core/sync/sync_coordinator.dart';
import 'package:monex/core/sync/sync_coordinator_impl.dart';
import 'package:monex/core/sync/sync_engine.dart';
import 'package:monex/core/sync/sync_engine_impl.dart';
import 'package:monex/core/usecase/sync_usecase.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source_impl.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source_impl.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source_impl.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source_impl.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void registerCoreDependencies() {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<PendingOperationsDao>(
    () => PendingOperationsDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<PendingOperationsLocalDataSource>(
    () => PendingOperationsLocalDataSourceImpl(getIt<PendingOperationsDao>()),
  );
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<SecureStorage>(
    () => SecureStorage(getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<ExpensesDao>(
    () => ExpensesDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(
      expenseDao: getIt<ExpensesDao>(),
      pendingOperationsDao: getIt<PendingOperationsDao>(),
      appDatabase: getIt<AppDatabase>(),
    ),
  );
  getIt.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<IncomesRemoteDataSource>(
    () => IncomesRemoteDataSourceImpl(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<IncomesDao>(
    () => IncomesDao(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<IncomesLocalDataSource>(
    () => IncomesLocalDataSourceImpl(
      appDatabase: getIt<AppDatabase>(),
      pendingOperationsDao: getIt<PendingOperationsDao>(),
      incomesDao: getIt<IncomesDao>(),
    ),
  );
  getIt.registerLazySingleton<SyncEngine>(
    () => SyncEngineImpl(
      pendingOperationsLocalDataSource:
          getIt<PendingOperationsLocalDataSource>(),
      expenseRemoteDataSource: getIt<ExpenseRemoteDataSource>(),
      expenseLocalDataSource: getIt<ExpenseLocalDataSource>(),
      incomesLocalDataSource: getIt<IncomesLocalDataSource>(),
      incomeRemoteDataSource: getIt<IncomesRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<SyncUsecase>(
    () => SyncUsecase(getIt<SyncEngine>()),
  );
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<SyncCoordinator>(
    () =>
        SyncCoordinatorImpl(getIt<ConnectivityService>(), getIt<SyncUsecase>()),
  );
}
