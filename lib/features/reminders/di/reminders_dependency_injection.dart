import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/local/database/app_database.dart';
import 'package:monex/core/local/database/dao/pending_operations_dao.dart';
import 'package:monex/core/local/database/dao/reminders_dao.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/repository/reminders_repository_impl.dart';
import 'package:monex/features/reminders/data/sources/local/reminders_local_data_source.dart';
import 'package:monex/features/reminders/data/sources/local/reminders_local_data_source_impl.dart';
import 'package:monex/features/reminders/data/sources/remote/reminders_remote_data_source.dart';
import 'package:monex/features/reminders/data/sources/remote/reminders_remote_data_source_impl.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';
import 'package:monex/features/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:monex/features/reminders/domain/usecases/delete_reminder_usecase.dart';
import 'package:monex/features/reminders/domain/usecases/get_reminder_by_id_usecase.dart';
import 'package:monex/features/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:monex/features/reminders/domain/usecases/watch_reminder_usecase.dart';
import 'package:monex/features/reminders/presentation/cubit/add_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/delete_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/get_reminder_by_id_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/update_reminder_cubit.dart';
import 'package:monex/features/reminders/presentation/cubit/watch_reminder_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerRemindersDependencies() {
  
  getIt.registerLazySingleton<ReminderRepository>(
    () => RemindersRepositoryImpl(getIt<RemindersLocalDataSource>()),
  );
  getIt.registerLazySingleton<AddReminderUsecase>(
    () => AddReminderUsecase(reminderRepository: getIt<ReminderRepository>(), notificationService: getIt<NotificationService>(), notificationScheduleCalculator: getIt<NotificationScheduleCalculator>()),
  );
  getIt.registerLazySingleton<UpdateReminderUsecase>(
    () => UpdateReminderUsecase( reminderRepository: getIt<ReminderRepository>(), notificationService: getIt<NotificationService>(), notificationScheduleCalculator: getIt<NotificationScheduleCalculator>() ),
  );
  getIt.registerLazySingleton<DeleteReminderUsecase>(
    () => DeleteReminderUsecase(
      reminderRepository: getIt<ReminderRepository>(),
      notificationService: getIt<NotificationService>(),
      notificationScheduleCalculator: getIt<NotificationScheduleCalculator>(),
    ),
  );
  getIt.registerLazySingleton<GetReminderByIdUsecase>(
    () => GetReminderByIdUsecase(getIt<ReminderRepository>()),
  );
  getIt.registerLazySingleton<WatchReminderUsecase>(
    () => WatchReminderUsecase(getIt<ReminderRepository>()),
  );
  getIt.registerFactory<AddReminderCubit>(
    () => AddReminderCubit(getIt<AddReminderUsecase>()),
  );
  getIt.registerFactory<UpdateReminderCubit>(
    () => UpdateReminderCubit(getIt<UpdateReminderUsecase>()),
  );
  getIt.registerFactory<DeleteReminderCubit>(
    () => DeleteReminderCubit(getIt<DeleteReminderUsecase>()),
  );
  getIt.registerFactory<WatchReminderCubit>(
    () => WatchReminderCubit(getIt<WatchReminderUsecase>()),
  );
  getIt.registerFactory<GetReminderByIdCubit>(
    () => GetReminderByIdCubit(getIt<GetReminderByIdUsecase>()),
  );
}
