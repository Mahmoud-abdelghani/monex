import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/savings/domain/usecase/update_saving_usecase.dart';

part 'update_saving_state.dart';

class UpdateSavingCubit extends Cubit<UpdateSavingState> {
  UpdateSavingCubit(this.updateSavingUsecase) : super(UpdateSavingInitial());
  final UpdateSavingUsecase updateSavingUsecase;
  Future<void> updateSaving({
    required String goalId,
    required double amount,
    required DateTime date,
    required String id,
  }) {
    emit(UpdateSavingLoading());
    return updateSavingUsecase
        .call(goalId: goalId, amount: amount, date: date, id: id)
        .then(
          (value) => value.fold(
            (failure) => emit(UpdateSavingFailure(failure.message)),
            (_) => emit(UpdateSavingSuccess()),
          ),
        );
  }
}
