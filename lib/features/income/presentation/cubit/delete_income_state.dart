part of 'delete_income_cubit.dart';

@immutable
sealed class DeleteIncomeState {}

final class DeleteIncomeInitial extends DeleteIncomeState {}
final class DeleteIncomeLoading extends DeleteIncomeState {}
final class DeleteIncomeSuccess extends DeleteIncomeState {}
final class DeleteIncomeFailure extends DeleteIncomeState {
  final String message;
  DeleteIncomeFailure(this.message);
}
