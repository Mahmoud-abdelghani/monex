part of 'login_with_email_password_cubit.dart';

@immutable
sealed class LoginWithEmailPasswordState {}

final class LoginWithEmailPasswordInitial extends LoginWithEmailPasswordState {}
final class LoginWithEmailPasswordLoading extends LoginWithEmailPasswordState {}
final class LoginWithEmailPasswordFailure extends LoginWithEmailPasswordState {
  final String message;
  LoginWithEmailPasswordFailure(this.message);
}
final class LoginWithEmailPasswordSuccess extends LoginWithEmailPasswordState {
  final UserEntity userEntity;
  LoginWithEmailPasswordSuccess(this.userEntity);
}
