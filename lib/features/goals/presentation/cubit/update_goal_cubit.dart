import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/usecase/update_goal_usecase.dart';

part 'update_goal_state.dart';

class UpdateGoalCubit extends Cubit<UpdateGoalState> {
  UpdateGoalCubit(this.updateGoalUsecase) : super(UpdateGoalInitial());
  final UpdateGoalUsecase updateGoalUsecase;
Future<void> updateGoal({
   required String title,
    required double targetAmount,
    required DateTime deadline,
    required GoalStatus status,
    required ContributionPeriod contributionPeriod,
    required String goalId,
})async{
emit(UpdateGoalLoading());
final result = await updateGoalUsecase.call(
  title: title,
  targetAmount: targetAmount,
  deadline: deadline,
  status: status,
  contributionPeriod: contributionPeriod,
  goalId: goalId,
);
result.fold(
  (failure) => emit(UpdateGoalFailure(message: failure.message)),
  (r) => emit(UpdateGoalSuccess()),
);
}
}
