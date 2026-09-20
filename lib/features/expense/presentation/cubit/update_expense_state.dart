part of 'update_expense_cubit.dart';

@immutable
sealed class UpdateExpenseState {}

final class UpdateExpenseInitial extends UpdateExpenseState {}
final class UpdateExpenseLoading extends UpdateExpenseState {}
final class UpdateExpenseSuccess extends UpdateExpenseState {

}
final class UpdateExpenseFailure extends UpdateExpenseState {
  final String message;
  UpdateExpenseFailure(this.message);
}
