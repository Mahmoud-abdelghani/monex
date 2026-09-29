import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/budget_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/features/budget/data/repository/budget_repository_impl.dart';
import 'package:monex/features/budget/data/source/local/budget_local_data_source.dart';
import 'package:monex/features/budget/data/source/local/budget_local_data_source_impl.dart';
import 'package:monex/features/budget/domain/repository/budget_repository.dart';
import 'package:monex/features/budget/domain/usecase/create_budget_usecase.dart';
import 'package:monex/features/budget/domain/usecase/get_current_budget_usecase.dart';
import 'package:monex/features/budget/domain/usecase/update_budget_usecase.dart';
import 'package:monex/features/budget/domain/usecase/watch_budget_usecase.dart';
import 'package:monex/features/budget/presentation/cubit/create_budget_cubit.dart';
import 'package:monex/features/budget/presentation/cubit/get_current_budget_cubit.dart';
import 'package:monex/features/budget/presentation/cubit/update_budget_cubit.dart';
import 'package:monex/features/budget/presentation/cubit/watch_budget_cubit.dart';

void registerBudgetDependencies() {
  
  getIt.registerLazySingleton<BudgetRepository>(
    () => BudgetRepositoryImpl(getIt<BudgetLocalDataSource>()),
  );
  getIt.registerLazySingleton<WatchBudgetUsecase>(
    () => WatchBudgetUsecase(getIt<BudgetRepository>()),
  );
  getIt.registerLazySingleton<CreateBudgetUsecase>(
    () => CreateBudgetUsecase(getIt<BudgetRepository>()),
  );
  getIt.registerLazySingleton<UpdateBudgetUsecase>(
    () => UpdateBudgetUsecase(getIt<BudgetRepository>()),
  );
  getIt.registerLazySingleton<GetCurrentBudgetUsecase>(
    () => GetCurrentBudgetUsecase(getIt<BudgetRepository>()),
  );
  getIt.registerFactory<WatchBudgetCubit>(
    () => WatchBudgetCubit(getIt<WatchBudgetUsecase>()),
  );
  getIt.registerFactory<CreateBudgetCubit>(
    () => CreateBudgetCubit(getIt<CreateBudgetUsecase>()),
  );
  getIt.registerFactory<UpdatebudgetCubit>(
    () => UpdatebudgetCubit(getIt<UpdateBudgetUsecase>()),
  );
  getIt.registerFactory<GetCurrentBudgetCubit>(
    () => GetCurrentBudgetCubit(getIt<GetCurrentBudgetUsecase>()),
  );
}
