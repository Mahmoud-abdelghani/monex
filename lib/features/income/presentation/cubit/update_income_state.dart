part of 'update_income_cubit.dart';

@immutable
sealed class UpdateIncomeState {}

final class UpdateIncomeInitial extends UpdateIncomeState {}
final class UpdateIncomeLoading extends UpdateIncomeState {}
final class UpdateIncomeSuccess extends UpdateIncomeState {}
final class UpdateIncomeFailure extends UpdateIncomeState {
  final String message;
  UpdateIncomeFailure(this.message);
}

