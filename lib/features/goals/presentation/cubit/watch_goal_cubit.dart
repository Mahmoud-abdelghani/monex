import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/usecase/watch_goals_usecase.dart';

part 'watch_goal_state.dart';

class WatchGoalCubit extends Cubit<WatchGoalState> {
  WatchGoalCubit(this.watchGoalsUsecase) : super(WatchGoalInitial());
  final WatchGoalsUsecase watchGoalsUsecase;
  StreamSubscription? _subscription;

  Future<void> watchGoals() async {
    emit(WatchGoalLoading());
    _subscription?.cancel();
    
    _subscription = watchGoalsUsecase().listen((event) {
      event.fold(
        (l) => emit(WatchGoalFailure(l.message)),
        (goals) => emit(WatchGoalSuccess(goals)),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
