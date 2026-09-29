part of 'watch_budget_cubit.dart';

@immutable
sealed class WatchBudgetState {}

final class WatchBudgetInitial extends WatchBudgetState {}
final class WatchBudgetLoading extends WatchBudgetState {}
final class WatchBudgetSuccess extends WatchBudgetState {
  final BudgetEntity? budget;
  WatchBudgetSuccess(this.budget);
}
final class WatchBudgetFailure extends WatchBudgetState {
  final String message;
  WatchBudgetFailure(this.message);
}
