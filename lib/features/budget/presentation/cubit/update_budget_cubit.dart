import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/budget/domain/usecase/update_budget_usecase.dart';

part 'update_budget_state.dart';

class UpdatebudgetCubit extends Cubit<UpdatebudgetState> {
  UpdatebudgetCubit(this.updateBudgetUsecase) : super(UpdatebudgetInitial());
  final UpdateBudgetUsecase updateBudgetUsecase;

  Future<void> updateBudget({
    required String budgetId,
    required double balance,
  }) async {
    emit(UpdatebudgetLoading());
    final result = await updateBudgetUsecase.call(
      budgetId: budgetId,
      balance: balance,
    );
    result.fold(
      (l) => emit(UpdatebudgetFailure(l.message)),
      (r) => emit(UpdatebudgetSuccess()),
    );
  }
}
