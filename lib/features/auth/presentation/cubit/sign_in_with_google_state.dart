part of 'sign_in_with_google_cubit.dart';

@immutable
sealed class SignInWithGoogleState {}

final class SignInWithGoogleInitial extends SignInWithGoogleState {}
final class SignInWithGoogleLoading extends SignInWithGoogleState {}
final class SignInWithGoogleSuccess extends SignInWithGoogleState {
  final UserEntity userEntity;
  SignInWithGoogleSuccess({required this.userEntity});
}
final class SignInWithGoogleFailure extends SignInWithGoogleState {
  final String message;
  SignInWithGoogleFailure({required this.message});
}
