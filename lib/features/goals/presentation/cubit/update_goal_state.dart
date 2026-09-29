part of 'update_goal_cubit.dart';

@immutable
sealed class UpdateGoalState {}

final class UpdateGoalInitial extends UpdateGoalState {}
final class UpdateGoalLoading extends UpdateGoalState {}
final class UpdateGoalSuccess extends UpdateGoalState {}
final class UpdateGoalFailure extends UpdateGoalState {
  final String message;
  UpdateGoalFailure({required this.message});
}
