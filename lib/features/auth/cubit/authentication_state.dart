part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class UpdatePasswordLoading extends AuthenticationState {}
final class UpdatePasswordSuccess extends AuthenticationState {}
final class UpdatePasswordFailure extends AuthenticationState {
  final String message;
  UpdatePasswordFailure(this.message);
}


final class ForgetPasswordLoading extends AuthenticationState {}

final class ForgetPasswordSuccess extends AuthenticationState {}
final class ForgetPasswordFailure extends AuthenticationState {
  final String message;
  ForgetPasswordFailure(this.message);
}

final class VerificationLoading extends AuthenticationState {}

final class VerificationSuccess extends AuthenticationState {}

final class VerificationFailure extends AuthenticationState {
  final String message;
  VerificationFailure(this.message);
}

final class AuthenticationSignInLoading extends AuthenticationState {}

final class AuthenticationSignInSuccess extends AuthenticationState {}

final class AuthenticationSignInFailure extends AuthenticationState {
  final String message;
  AuthenticationSignInFailure(this.message);
}

final class AuthenticationLoginWithGoogleLoading extends AuthenticationState {}

final class AuthenticationLoginWithGoogleSuccess extends AuthenticationState {}

final class AuthenticationLoginWithGoogleFailure extends AuthenticationState {
  final String message;
  AuthenticationLoginWithGoogleFailure(this.message);
}

final class AuthenticationLogoutLoading extends AuthenticationState {}

final class AuthenticationLogoutSuccess extends AuthenticationState {}

final class AuthenticationLogoutFailure extends AuthenticationState {
  final String message;
  AuthenticationLogoutFailure(this.message);
}

final class AuthenticationSignUpLoading extends AuthenticationState {}

final class AuthenticationSignUpSuccess extends AuthenticationState {
  final String email;
  final String password;

  AuthenticationSignUpSuccess({required this.email, required this.password});
}

final class AuthenticationSignUpFailure extends AuthenticationState {
  final String message;
  AuthenticationSignUpFailure(this.message);
}
