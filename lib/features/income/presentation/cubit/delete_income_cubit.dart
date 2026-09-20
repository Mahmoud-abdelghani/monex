import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/income/domain/usecase/delete_income_usecase.dart';

part 'delete_income_state.dart';

class DeleteIncomeCubit extends Cubit<DeleteIncomeState> {
  DeleteIncomeCubit(this.deleteIncomeUsecase) : super(DeleteIncomeInitial());
  final DeleteIncomeUsecase deleteIncomeUsecase;

  Future<void> deleteIncome(String incomeId) async {
    emit(DeleteIncomeLoading());
    final result = await deleteIncomeUsecase(incomeId);
    result.fold(
      (l) => emit(DeleteIncomeFailure(l.message)),
      (r) => emit(DeleteIncomeSuccess()),
    );
  }
}
