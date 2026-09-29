import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/goals/domain/usecase/add_goal_usecase.dart';

part 'add_goal_state.dart';

class AddGoalCubit extends Cubit<AddGoalState> {
  AddGoalCubit(this.addGoalUsecase) : super(AddGoalInitial());
  final AddGoalUsecase addGoalUsecase;

  Future<void> addGoal({
    required String title,
    required double targetAmount,
    required DateTime deadline,
    required GoalStatus status,
    required ContributionPeriod contributionPeriod,
  }) async {
    emit(AddGoalLoading());
    final result = await addGoalUsecase.call(
      title: title,
      targetAmount: targetAmount,
      deadline: deadline,
      status: status,
      contributionPeriod: contributionPeriod,
    );
    result.fold(
      (failure) => emit(AddGoalFailure(message: failure.message)),
      (r) => emit(AddGoalSuccess()),
    );
  }
}
