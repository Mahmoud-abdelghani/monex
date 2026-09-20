import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:monex/features/auth/data/repository/auth_repository_impl.dart';
import 'package:monex/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:monex/features/auth/data/source/remote/auth_remote_data_source_impl.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/usecase/change_password.dart';
import 'package:monex/features/auth/domain/usecase/login_with_email_password.dart';
import 'package:monex/features/auth/domain/usecase/logout.dart';
import 'package:monex/features/auth/domain/usecase/register.dart';
import 'package:monex/features/auth/domain/usecase/send_email_reset_password.dart';
import 'package:monex/features/auth/domain/usecase/sign_in_with_google.dart';
import 'package:monex/features/auth/presentation/cubit/change_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/login_with_email_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/register_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/send_email_reset_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/sign_in_with_google_cubit.dart';

void registerAuthDependencies() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<SupabaseService>().supabase),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LoginWithEmailPasswordUseCase>(
    () => LoginWithEmailPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SendEmailResetPasswordUseCase>(
    () => SendEmailResetPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterUseCase>()),
  );
  getIt.registerFactory<LoginWithEmailPasswordCubit>(
    () => LoginWithEmailPasswordCubit(getIt<LoginWithEmailPasswordUseCase>()),
  );
  getIt.registerFactory<SignInWithGoogleCubit>(
    () => SignInWithGoogleCubit(getIt<SignInWithGoogleUseCase>()),
  );
  getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt<LogoutUseCase>()));
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(getIt<ChangePasswordUseCase>()),
  );
  getIt.registerFactory<SendEmailResetPasswordCubit>(
    () => SendEmailResetPasswordCubit(getIt<SendEmailResetPasswordUseCase>()),
  );
}
