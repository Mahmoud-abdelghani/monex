part of 'complete_goal_cubit.dart';

@immutable
sealed class CompleteGoalState {}

final class CompleteGoalInitial extends CompleteGoalState {}
final class CompleteGoalLoading extends CompleteGoalState {}
final class CompleteGoalSuccess extends CompleteGoalState {}
final class CompleteGoalFailure extends CompleteGoalState {
  final String message;
  CompleteGoalFailure(this.message);
}
