import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/usecase/watch_expenses_use_case.dart';

part 'watch_expenses_state.dart';

class WatchExpensesCubit extends Cubit<WatchExpensesState> {
  WatchExpensesCubit(this.watchExpensesUseCase) : super(WatchExpensesInitial());
  final WatchExpensesUseCase watchExpensesUseCase;
  StreamSubscription? _expensesSubscription;

  void watchExpenses() {
    emit(WatchExpensesLoading());

    _expensesSubscription?.cancel();

    _expensesSubscription = watchExpensesUseCase().listen((data) {
      data.fold(
        (failure) => emit(WatchExpensesFailure(failure.message)),
        (expenses) => emit(WatchExpensesSuccess(expenses)),
      );
    });
  }

  @override
  Future<void> close() {
    _expensesSubscription?.cancel();
    return super.close();
  }
}
