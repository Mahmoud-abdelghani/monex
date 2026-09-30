part of 'add_reminder_cubit.dart';

@immutable
sealed class AddReminderState {}

final class AddReminderInitial extends AddReminderState {}
final class AddReminderLoading extends AddReminderState {}
final class AddReminderSuccess extends AddReminderState {}
final class AddReminderFailure extends AddReminderState {
  final String message;
  AddReminderFailure(this.message);
}
