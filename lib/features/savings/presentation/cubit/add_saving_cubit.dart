import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/savings/domain/usecase/add_saving_usecase.dart';

part 'add_saving_state.dart';

class AddSavingCubit extends Cubit<AddSavingState> {
  AddSavingCubit(this.addSavingUsecase) : super(AddSavingInitial());
  final AddSavingUsecase addSavingUsecase;

  Future<void> addSaving({
    required String goalId,
    required double amount,
    required DateTime date,
  }) async {
    emit(AddSavingLoading());
    final result = await addSavingUsecase.call(
      goalId: goalId,
      amount: amount,
      date: date,
    );
    result.fold(
      (failure) => emit(AddSavingFailure(failure.message)),
      (_) => emit(AddSavingSuccess()),
    );
  }
}
