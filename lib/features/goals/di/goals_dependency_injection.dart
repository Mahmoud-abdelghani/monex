import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/goals_dao.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/features/goals/data/repository/goals_repository_impl.dart';
import 'package:monex/features/goals/data/source/local/goals_local_data_source.dart';
import 'package:monex/features/goals/data/source/local/goals_local_data_source_impl.dart';
import 'package:monex/features/goals/domain/repository/goals_repository.dart';
import 'package:monex/features/goals/domain/usecase/add_goal_usecase.dart';
import 'package:monex/features/goals/domain/usecase/complete_goal_usecase.dart';
import 'package:monex/features/goals/domain/usecase/delete_goal_usecase.dart';
import 'package:monex/features/goals/domain/usecase/get_goal_by_id_usecase.dart';
import 'package:monex/features/goals/domain/usecase/update_goal_usecase.dart';
import 'package:monex/features/goals/domain/usecase/watch_goals_usecase.dart';
import 'package:monex/features/goals/presentation/cubit/add_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/complete_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/delete_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/update_goal_cubit.dart';
import 'package:monex/features/goals/presentation/cubit/watch_goal_cubit.dart';

void registerGoalsDependencies() {
  getIt.registerLazySingleton<GoalsRepository>(
    () => GoalsRepositoryImpl(getIt<GoalsLocalDataSource>()),
  );
  getIt.registerLazySingleton<AddGoalUsecase>(
    () => AddGoalUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerLazySingleton<WatchGoalsUsecase>(
    () => WatchGoalsUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerLazySingleton<CompleteGoalUsecase>(
    () => CompleteGoalUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerLazySingleton<DeleteGoalUsecase>(
    () => DeleteGoalUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerLazySingleton<GetGoalByIdUsecase>(
    () => GetGoalByIdUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerLazySingleton<UpdateGoalUsecase>(
    () => UpdateGoalUsecase(getIt<GoalsRepository>()),
  );
  getIt.registerFactory<AddGoalCubit>(
    () => AddGoalCubit(getIt<AddGoalUsecase>()),
  );
  getIt.registerFactory<WatchGoalCubit>(
    () => WatchGoalCubit(getIt<WatchGoalsUsecase>()),
  );
  getIt.registerFactory<UpdateGoalCubit>(
    () => UpdateGoalCubit(getIt<UpdateGoalUsecase>()),
  );
  getIt.registerFactory<DeleteGoalCubit>(
    () => DeleteGoalCubit(getIt<DeleteGoalUsecase>()),
  );
  getIt.registerFactory<CompleteGoalCubit>(
    () => CompleteGoalCubit(getIt<CompleteGoalUsecase>()),
  );
}
