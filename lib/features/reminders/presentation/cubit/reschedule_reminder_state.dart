part of 'reschedule_reminder_cubit.dart';

@immutable
sealed class RescheduleReminderState {}

final class RescheduleReminderInitial extends RescheduleReminderState {}

final class RescheduleReminderLoading extends RescheduleReminderState {}

final class RescheduleReminderSuccess extends RescheduleReminderState {}

final class RescheduleReminderFailure extends RescheduleReminderState {
  final String message;
  RescheduleReminderFailure(this.message);
}
