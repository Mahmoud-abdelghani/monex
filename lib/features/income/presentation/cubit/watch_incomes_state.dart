part of 'watch_incomes_cubit.dart';

@immutable
sealed class WatchIncomesState {}

final class WatchIncomesInitial extends WatchIncomesState {}
final class WatchIncomesLoading extends WatchIncomesState {}
final class WatchIncomesSuccess extends WatchIncomesState {
  final List<IncomeEntity> incomes;
  WatchIncomesSuccess(this.incomes);
}
final class WatchIncomesFailure extends WatchIncomesState {
  final String message;
  WatchIncomesFailure(this.message);
}
