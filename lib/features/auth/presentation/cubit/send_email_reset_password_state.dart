part of 'send_email_reset_password_cubit.dart';

@immutable
sealed class SendEmailResetPasswordState {}

final class SendEmailResetPasswordInitial extends SendEmailResetPasswordState {}
final class SendEmailResetPasswordLoading extends SendEmailResetPasswordState {}
final class SendEmailResetPasswordSuccess extends SendEmailResetPasswordState {
  final String message;
  SendEmailResetPasswordSuccess(this.message);
}
final class SendEmailResetPasswordFailure extends SendEmailResetPasswordState {
  final String message;
  SendEmailResetPasswordFailure(this.message);
}
