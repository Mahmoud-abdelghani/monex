import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/incomes_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/features/income/data/repository/incomes_repository_impl.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source.dart';
import 'package:monex/features/income/data/source/local/incomes_local_data_source_impl.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source_impl.dart';
import 'package:monex/features/income/domain/repository/incomes_repository.dart';
import 'package:monex/features/income/domain/usecase/add_income_usecase.dart';
import 'package:monex/features/income/domain/usecase/delete_income_usecase.dart';
import 'package:monex/features/income/domain/usecase/get_income_by_id_usecase.dart';
import 'package:monex/features/income/domain/usecase/update_income_usecase.dart';
import 'package:monex/features/income/domain/usecase/watch_incomes_usecase.dart';
import 'package:monex/features/income/presentation/cubit/add_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/delete_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/update_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/watch_incomes_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerIncomesDependencies() {
 
  getIt.registerLazySingleton<IncomesRepository>(
    () => IncomesRepositoryImpl(getIt<IncomesLocalDataSource>()),
  );
  getIt.registerLazySingleton<AddIncomeUsecase>(
    () => AddIncomeUsecase(getIt<IncomesRepository>()),
  );
  getIt.registerLazySingleton<UpdateIncomeUsecase>(
    () => UpdateIncomeUsecase(getIt<IncomesRepository>()),
  );
  getIt.registerLazySingleton<DeleteIncomeUsecase>(
    () => DeleteIncomeUsecase(getIt<IncomesRepository>()),
  );
  getIt.registerLazySingleton<GetIncomeByIdUsecase>(
    () => GetIncomeByIdUsecase(getIt<IncomesRepository>()),
  );
  getIt.registerLazySingleton<WatchIncomesUsecase>(
    () => WatchIncomesUsecase(getIt<IncomesRepository>()),
  );
  getIt.registerFactory<WatchIncomesCubit>(
    () => WatchIncomesCubit(getIt<WatchIncomesUsecase>()),
  );
  getIt.registerFactory<UpdateIncomeCubit>(
    () => UpdateIncomeCubit(getIt<UpdateIncomeUsecase>()),
  );
  getIt.registerFactory<DeleteIncomeCubit>(
    () => DeleteIncomeCubit(getIt<DeleteIncomeUsecase>()),
  );
  getIt.registerFactory<AddIncomeCubit>(
    () => AddIncomeCubit(getIt<AddIncomeUsecase>()),
  );
}
