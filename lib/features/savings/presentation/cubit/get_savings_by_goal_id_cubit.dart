import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';
import 'package:monex/features/savings/domain/usecase/get_savings_by_goal_id_usecase.dart';

part 'get_savings_by_goal_id_state.dart';

class GetSavingsByGoalIdCubit extends Cubit<GetSavingsByGoalIdState> {
  GetSavingsByGoalIdCubit(this.getSavingsByGoalIdUsecase)
    : super(GetSavingsByGoalIdInitial());
  final GetSavingsByGoalIdUsecase getSavingsByGoalIdUsecase;

  Future<void> getSavingsByGoalId(String goalId) async {
    emit(GetSavingsByGoalIdLoading());
    final result = await getSavingsByGoalIdUsecase.call(goalId);
    result.fold(
      (failure) => emit(GetSavingsByGoalIdFailure(failure.message)),
      (data) => emit(GetSavingsByGoalIdSuccess(data)),
    );
  }
}
