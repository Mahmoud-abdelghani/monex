import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/budget/domain/entities/budget_entity.dart';
import 'package:monex/features/budget/domain/usecase/get_current_budget_usecase.dart';

part 'get_current_budget_state.dart';

class GetCurrentBudgetCubit extends Cubit<GetCurrentBudgetState> {
  GetCurrentBudgetCubit(this.getCurrentBudgetUsecase) : super(GetCurrentBudgetInitial());
  final GetCurrentBudgetUsecase getCurrentBudgetUsecase;

  Future<void> getCurrentBudget() async {
    emit(GetCurrentBudgetLoading());
    final failureOrBudget = await getCurrentBudgetUsecase();
    failureOrBudget.fold((failure) => emit(GetCurrentBudgetFailure(failure.message)), (budget) => emit(GetCurrentBudgetSuccess(budget)));
  }
}
