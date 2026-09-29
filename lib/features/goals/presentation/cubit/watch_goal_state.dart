part of 'watch_goal_cubit.dart';

@immutable
sealed class WatchGoalState {}

final class WatchGoalInitial extends WatchGoalState {}

final class WatchGoalLoading extends WatchGoalState {}

final class WatchGoalSuccess extends WatchGoalState {
  final List<GoalEntity> goals;
  WatchGoalSuccess(this.goals);
}

final class WatchGoalFailure extends WatchGoalState {
  final String message;
  WatchGoalFailure(this.message);
}
