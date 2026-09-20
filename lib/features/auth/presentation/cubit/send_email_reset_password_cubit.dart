import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/usecase/send_email_reset_password.dart';

part 'send_email_reset_password_state.dart';

class SendEmailResetPasswordCubit extends Cubit<SendEmailResetPasswordState> {
  SendEmailResetPasswordCubit(this.sendEmailResetPasswordUseCase) : super(SendEmailResetPasswordInitial());
  final SendEmailResetPasswordUseCase sendEmailResetPasswordUseCase;

  Future<void> sendEmailResetPassword({
    required String userEmail,
  })async {
    emit(SendEmailResetPasswordLoading());
    final result = await sendEmailResetPasswordUseCase(userEmail: userEmail);
    result.fold(
      (failure) => emit(SendEmailResetPasswordFailure(failure.message)),
      (sucess) => emit(SendEmailResetPasswordSuccess('email sent successfully Verify your email')),
    );
  }
}
