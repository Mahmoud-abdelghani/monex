import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/usecase/watch_incomes_usecase.dart';

part 'watch_incomes_state.dart';

class WatchIncomesCubit extends Cubit<WatchIncomesState> {
  WatchIncomesCubit(this.watchIncomesUsecase) : super(WatchIncomesInitial());
  final WatchIncomesUsecase watchIncomesUsecase;

  StreamSubscription? streamSubscription;

  void watchIncomes()async{
    streamSubscription?.cancel();
    streamSubscription = watchIncomesUsecase().listen((event) {
      event.fold(
        (l) => emit(WatchIncomesFailure(l.message)),
        (incomes) => emit(WatchIncomesSuccess(incomes)),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

}
