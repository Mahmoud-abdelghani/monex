part of 'delete_expense_cubit.dart';

@immutable
sealed class DeleteExpenseState {}

final class DeleteExpenseInitial extends DeleteExpenseState {}
final class DeleteExpenseLoading extends DeleteExpenseState {}
final class DeleteExpenseFailure extends DeleteExpenseState {
  final String message;
  DeleteExpenseFailure(this.message);
}
final class DeleteExpenseSuccess extends DeleteExpenseState {}
