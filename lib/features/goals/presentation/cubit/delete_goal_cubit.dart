import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/goals/domain/usecase/delete_goal_usecase.dart';

part 'delete_goal_state.dart';

class DeleteGoalCubit extends Cubit<DeleteGoalState> {
  DeleteGoalCubit(this.deleteGoalUsecase) : super(DeleteGoalInitial());
  final DeleteGoalUsecase deleteGoalUsecase;

  Future<void> deleteGoal(String goalId) async {
    emit(DeleteGoalLoading());
    final result = await deleteGoalUsecase(goalId);
    result.fold((l) => emit(DeleteGoalFailure(l.message)), (r) => emit(DeleteGoalSuccess()));
  }
}
