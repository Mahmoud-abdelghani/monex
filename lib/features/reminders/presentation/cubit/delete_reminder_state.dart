part of 'delete_reminder_cubit.dart';

@immutable
sealed class DeleteReminderState {}

final class DeleteReminderInitial extends DeleteReminderState {}
final class DeleteReminderLoading extends DeleteReminderState {}
final class DeleteReminderSuccess extends DeleteReminderState {}
final class DeleteReminderFailure extends DeleteReminderState {
  final String message;
  DeleteReminderFailure(this.message);
}
