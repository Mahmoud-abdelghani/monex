import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/dao/savings_dao.dart';
import 'package:monex/features/savings/data/repository/savings_repository_impl.dart';
import 'package:monex/features/savings/data/source/local/savings_local_data_source.dart';
import 'package:monex/features/savings/data/source/local/savings_local_data_source_impl.dart';
import 'package:monex/features/savings/domain/repository/savings_repository.dart';
import 'package:monex/features/savings/domain/usecase/add_saving_usecase.dart';
import 'package:monex/features/savings/domain/usecase/delete_saving_usecase.dart';
import 'package:monex/features/savings/domain/usecase/get_savings_by_goal_id_usecase.dart';
import 'package:monex/features/savings/domain/usecase/update_saving_usecase.dart';
import 'package:monex/features/savings/domain/usecase/watch_savings_usecase.dart';
import 'package:monex/features/savings/presentation/cubit/add_saving_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/delete_saving_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/get_savings_by_goal_id_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/update_saving_cubit.dart';
import 'package:monex/features/savings/presentation/cubit/watch_savings_cubit.dart';

void registerSavingsDependencies() {
 

  getIt.registerLazySingleton<SavingsRepository>(
    () => SavingsRepositoryImpl(getIt<SavingsLocalDataSource>()),
  );
  getIt.registerLazySingleton<AddSavingUsecase>(
    () => AddSavingUsecase(getIt<SavingsRepository>()),
  );
  getIt.registerLazySingleton<UpdateSavingUsecase>(
    () => UpdateSavingUsecase(getIt<SavingsRepository>()),
  );
  getIt.registerLazySingleton<DeleteSavingUsecase>(
    () => DeleteSavingUsecase(getIt<SavingsRepository>()),
  );
  getIt.registerLazySingleton<GetSavingsByGoalIdUsecase>(
    () => GetSavingsByGoalIdUsecase(getIt<SavingsRepository>()),
  );
  getIt.registerLazySingleton<WatchSavingsUsecase>(
    () => WatchSavingsUsecase(getIt<SavingsRepository>()),
  );

  getIt.registerFactory<AddSavingCubit>(
    () => AddSavingCubit(getIt<AddSavingUsecase>()),
  );
  getIt.registerFactory<UpdateSavingCubit>(
    () => UpdateSavingCubit(getIt<UpdateSavingUsecase>()),
  );
  getIt.registerFactory<DeleteSavingCubit>(
    () => DeleteSavingCubit(getIt<DeleteSavingUsecase>()),
  );
  getIt.registerFactory<WatchSavingsCubit>(
    () => WatchSavingsCubit(getIt<WatchSavingsUsecase>()),
  );
  getIt.registerFactory<GetSavingsByGoalIdCubit>(
    () => GetSavingsByGoalIdCubit(getIt<GetSavingsByGoalIdUsecase>()),
  );
}
