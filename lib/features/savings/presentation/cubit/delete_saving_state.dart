part of 'delete_saving_cubit.dart';

@immutable
sealed class DeleteSavingState {}

final class DeleteSavingInitial extends DeleteSavingState {}
final class DeleteSavingLoading extends DeleteSavingState {}
final class DeleteSavingSuccess extends DeleteSavingState {}
final class DeleteSavingFailure extends DeleteSavingState {
  final String message;
  DeleteSavingFailure(this.message);
}
