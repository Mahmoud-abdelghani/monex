part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}
final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {
  final String message;
  LogoutSuccess(this.message);
}
final class LogoutFailure extends LogoutState {
  final String message;
  LogoutFailure(this.message);
}
