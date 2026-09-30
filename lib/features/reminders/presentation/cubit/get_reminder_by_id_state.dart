part of 'get_reminder_by_id_cubit.dart';

@immutable
sealed class GetReminderByIdState {}

final class GetReminderByIdInitial extends GetReminderByIdState {}
final class GetReminderByIdLoading extends GetReminderByIdState {}
final class GetReminderByIdSuccess extends GetReminderByIdState {
  final ReminderEntity?
   reminder;
  GetReminderByIdSuccess(this.reminder);
}
final class GetReminderByIdFailure extends GetReminderByIdState {
  final String message;
  GetReminderByIdFailure(this.message);
}
