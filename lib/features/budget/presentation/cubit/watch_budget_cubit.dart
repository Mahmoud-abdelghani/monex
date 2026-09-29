import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/usecase/watch_budget_usecase.dart';

part 'watch_budget_state.dart';

class WatchBudgetCubit extends Cubit<WatchBudgetState> {
  WatchBudgetCubit(this.watchBudgetUsecase) : super(WatchBudgetInitial());
  final WatchBudgetUsecase watchBudgetUsecase;

  StreamSubscription? _subscription;

  Future<void> watchBudget() async {
    _subscription?.cancel();
    _subscription = watchBudgetUsecase().listen((failureOrBudget) {
      failureOrBudget.fold(
        (failure) => emit(WatchBudgetFailure(failure.message)),
        (budget) => emit(WatchBudgetSuccess(budget)),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
