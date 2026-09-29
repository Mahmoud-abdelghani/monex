part of 'add_saving_cubit.dart';

@immutable
sealed class AddSavingState {}

final class AddSavingInitial extends AddSavingState {}
final class AddSavingLoading extends AddSavingState {}
final class AddSavingSuccess extends AddSavingState {}
final class AddSavingFailure extends AddSavingState {
  final String message;

  AddSavingFailure(this.message);
}
