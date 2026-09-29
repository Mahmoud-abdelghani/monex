import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/goals/domain/usecase/complete_goal_usecase.dart';

part 'complete_goal_state.dart';

class CompleteGoalCubit extends Cubit<CompleteGoalState> {
  CompleteGoalCubit(this.completeGoalUsecase) : super(CompleteGoalInitial());
  final CompleteGoalUsecase completeGoalUsecase;

  Future<void> completeGoal(String goalId) async {
    emit(CompleteGoalLoading());
    final result = await completeGoalUsecase(goalId);
    result.fold(
      (l) => emit(CompleteGoalFailure(l.message)),
      (r) => emit(CompleteGoalSuccess()),
    );
  }
}
