part of 'add_income_cubit.dart';

@immutable
sealed class AddIncomeState {}

final class AddIncomeInitial extends AddIncomeState {}
final class AddIncomeLoading extends AddIncomeState {}
final class AddIncomeSuccess extends AddIncomeState {}
final class AddIncomeFailure extends AddIncomeState {
  final String message;
  AddIncomeFailure(this.message);
}
