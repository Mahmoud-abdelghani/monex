part of 'watch_expenses_cubit.dart';

@immutable
sealed class WatchExpensesState {}

final class WatchExpensesInitial extends WatchExpensesState {}
final class WatchExpensesLoading extends WatchExpensesState {}
final class WatchExpensesFailure extends WatchExpensesState {
  final String message;
  WatchExpensesFailure(this.message);
}
final class WatchExpensesSuccess extends WatchExpensesState {
  final List<ExpenseEntity> expenses;
  WatchExpensesSuccess(this.expenses);
}
