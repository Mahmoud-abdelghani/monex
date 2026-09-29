import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/savings/domain/usecase/delete_saving_usecase.dart';

part 'delete_saving_state.dart';

class DeleteSavingCubit extends Cubit<DeleteSavingState> {
  DeleteSavingCubit(this.deleteSavingUsecase) : super(DeleteSavingInitial());
  final DeleteSavingUsecase deleteSavingUsecase;

  Future<void> deleteSaving(String savingId) async {
    emit(DeleteSavingLoading());
    final result = await deleteSavingUsecase.call(savingId);
    result.fold(
      (failure) => emit(DeleteSavingFailure(failure.message)),
      (_) => emit(DeleteSavingSuccess()),
    );
  }
}
