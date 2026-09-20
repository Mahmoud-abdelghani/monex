import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/usecase/change_password.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordUseCase) : super(ChangePasswordInitial());
  final ChangePasswordUseCase changePasswordUseCase;
  Future<void> changePassword({required String userNewPassword}) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordUseCase(userNewPassword: userNewPassword);
    result.fold(
      (failure) => emit(ChangePasswordFailure(failure.message)),
      (userEntity) => emit(ChangePasswordSuccess(userEntity)),
    );
  }
}
