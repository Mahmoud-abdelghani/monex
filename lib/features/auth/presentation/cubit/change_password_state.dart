part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}
final class ChangePasswordLoading extends ChangePasswordState {}
final class ChangePasswordSuccess extends ChangePasswordState {
  final UserEntity userEntity;
  ChangePasswordSuccess(this.userEntity);
}
final class ChangePasswordFailure extends ChangePasswordState {
  final String message;
  ChangePasswordFailure(this.message);
}
