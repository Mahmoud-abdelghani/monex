import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/usecase/watch_savings_usecase.dart';

part 'watch_savings_state.dart';

class WatchSavingsCubit extends Cubit<WatchSavingsState> {
  WatchSavingsCubit(this.watchSavingsUsecase) : super(WatchSavingsInitial());
  final WatchSavingsUsecase watchSavingsUsecase;
  StreamSubscription? _subscription;

  Future<void> watchSavings() async {
    emit(WatchSavingsLoading());
    _subscription?.cancel();
    _subscription = watchSavingsUsecase.call().listen((event) {
      event.fold(
        (failure) => emit(WatchSavingsFailure(failure.message)),
        (data) => emit(WatchSavingsSuccess(data)),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
