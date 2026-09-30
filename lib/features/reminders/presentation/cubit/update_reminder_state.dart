part of 'update_reminder_cubit.dart';

@immutable
sealed class UpdateReminderState {}

final class UpdateReminderInitial extends UpdateReminderState {}
final class UpdateReminderLoading
 extends UpdateReminderState {}
final class UpdateReminderSuccess extends UpdateReminderState {}
final class UpdateReminderFailure extends UpdateReminderState {
  final String message;
  UpdateReminderFailure(this.message);
}
