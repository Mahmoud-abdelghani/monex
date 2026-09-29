part of 'get_current_budget_cubit.dart';

@immutable
sealed class GetCurrentBudgetState {}

final class GetCurrentBudgetInitial extends GetCurrentBudgetState {}
final class GetCurrentBudgetLoading extends GetCurrentBudgetState {}
final class GetCurrentBudgetSuccess extends GetCurrentBudgetState {
  final BudgetEntity? budget;
  GetCurrentBudgetSuccess(this.budget);
}
final class GetCurrentBudgetFailure extends GetCurrentBudgetState {
  final String message;
  GetCurrentBudgetFailure(this.message);
}
