part of 'watch_savings_cubit.dart';

@immutable
sealed class WatchSavingsState {}

final class WatchSavingsInitial extends WatchSavingsState {}
final class WatchSavingsLoading extends WatchSavingsState {}
final class WatchSavingsSuccess extends WatchSavingsState {
  final List<SavingEntity> savings;
  WatchSavingsSuccess(this.savings);
}
final class WatchSavingsFailure extends WatchSavingsState {
  final String message;
  WatchSavingsFailure(this.message);
}
