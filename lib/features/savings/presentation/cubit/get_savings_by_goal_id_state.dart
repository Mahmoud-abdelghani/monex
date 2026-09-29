part of 'get_savings_by_goal_id_cubit.dart';

@immutable
sealed class GetSavingsByGoalIdState {}

final class GetSavingsByGoalIdInitial extends GetSavingsByGoalIdState {}
final class GetSavingsByGoalIdLoading extends GetSavingsByGoalIdState {}
final class GetSavingsByGoalIdSuccess extends GetSavingsByGoalIdState {
  final List<SavingEntity> savings;
  GetSavingsByGoalIdSuccess(this.savings);
}
final class GetSavingsByGoalIdFailure extends GetSavingsByGoalIdState {
  final String message;
  GetSavingsByGoalIdFailure(this.message);
}
