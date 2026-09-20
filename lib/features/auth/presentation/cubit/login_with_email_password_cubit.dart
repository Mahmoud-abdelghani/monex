import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/usecase/login_with_email_password.dart';

part 'login_with_email_password_state.dart';

class LoginWithEmailPasswordCubit extends Cubit<LoginWithEmailPasswordState> {
  LoginWithEmailPasswordCubit(this.loginWithEmailPasswordUseCase) : super(LoginWithEmailPasswordInitial());
  final LoginWithEmailPasswordUseCase loginWithEmailPasswordUseCase;

  Future<void> loginWithEmailPassword({
    required String userEmail,
    required String userPassword,
  }) async {
    emit(LoginWithEmailPasswordLoading());
    final result = await loginWithEmailPasswordUseCase(
      userEmail: userEmail,
      userPassword: userPassword,
    );
    result.fold(
      (failure) => emit(LoginWithEmailPasswordFailure(failure.message)),
      (userEntity) => emit(LoginWithEmailPasswordSuccess(userEntity)),
    );
  }

}
