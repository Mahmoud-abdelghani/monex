part of 'update_budget_cubit.dart';

@immutable
sealed class UpdatebudgetState {}

final class UpdatebudgetInitial extends UpdatebudgetState {}
final class UpdatebudgetLoading extends UpdatebudgetState {}
final class UpdatebudgetSuccess extends UpdatebudgetState {}
final class UpdatebudgetFailure extends UpdatebudgetState {
  final String message;
  UpdatebudgetFailure(this.message);
}
