part of 'update_saving_cubit.dart';

@immutable
sealed class UpdateSavingState {}

final class UpdateSavingInitial extends UpdateSavingState {}
final class UpdateSavingLoading extends UpdateSavingState {}
final class UpdateSavingSuccess extends UpdateSavingState {}
final class UpdateSavingFailure extends UpdateSavingState {
  final String message;
  UpdateSavingFailure(this.message);
}
