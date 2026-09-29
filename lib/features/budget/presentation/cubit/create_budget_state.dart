part of 'create_budget_cubit.dart';

@immutable
sealed class CreateBudgetState {}

final class CreateBudgetInitial extends CreateBudgetState {}
final class CreateBudgetLoading extends CreateBudgetState {}
final class CreateBudgetSuccess extends CreateBudgetState {}
final class CreateBudgetFailure extends CreateBudgetState {
  final String message;
  CreateBudgetFailure(this.message);
}
