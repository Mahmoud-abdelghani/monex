part of 'watch_reminder_cubit.dart';

@immutable
sealed class WatchReminderState {}

final class WatchReminderInitial extends WatchReminderState {}
final class WatchReminderLoading extends WatchReminderState {}
final class WatchReminderSuccess extends WatchReminderState {
  final List<ReminderEntity> reminders;
  WatchReminderSuccess(this.reminders);
}
final class WatchReminderFailure extends WatchReminderState {
  final String message;
  WatchReminderFailure(this.message);
}
