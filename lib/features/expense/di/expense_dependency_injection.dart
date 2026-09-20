import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/expenses_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/features/expense/data/repository/expense_repository_impl.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source.dart';
import 'package:monex/features/expense/data/source/local/expense_local_data_source_impl.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source_impl.dart';
import 'package:monex/features/expense/domain/repository/expense_repository.dart';
import 'package:monex/features/expense/domain/usecase/delete_expense_use_case.dart';
import 'package:monex/features/expense/domain/usecase/update_expense_use_case.dart';
import 'package:monex/features/expense/domain/usecase/watch_expenses_use_case.dart';
import 'package:monex/features/expense/presentation/cubit/delete_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/update_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/watch_expenses_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerExpenseDependencies() {
 
  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      getIt<ExpenseLocalDataSource>(),
      getIt<ExpenseRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<WatchExpensesUseCase>(
    () => WatchExpensesUseCase(getIt<ExpenseRepository>()),
  );
  getIt.registerLazySingleton<UpdateExpenseUseCase>(
    () => UpdateExpenseUseCase(getIt<ExpenseRepository>()),
  );
  getIt.registerLazySingleton<DeleteExpenseUseCase>(
    () => DeleteExpenseUseCase(getIt<ExpenseRepository>()),
  );
  getIt.registerFactory<WatchExpensesCubit>(
    () => WatchExpensesCubit(getIt<WatchExpensesUseCase>()),
  );
  getIt.registerFactory<UpdateExpenseCubit>(
    () => UpdateExpenseCubit(getIt<UpdateExpenseUseCase>()),
  );
  getIt.registerFactory<DeleteExpenseCubit>(
    () => DeleteExpenseCubit(getIt<DeleteExpenseUseCase>()),
  );
}
