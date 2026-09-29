import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/budget/domain/usecase/create_budget_usecase.dart';

part 'create_budget_state.dart';

class CreateBudgetCubit extends Cubit<CreateBudgetState> {
  CreateBudgetCubit(this.createBudgetUsecase) : super(CreateBudgetInitial());
  final CreateBudgetUsecase createBudgetUsecase;

  Future<void> createBudget({required double balance}) async {
    emit(CreateBudgetLoading());
    final result = await createBudgetUsecase(balance: balance);
    result.fold(
      (failure) => emit(CreateBudgetFailure(failure.message)),
      (_) => emit(CreateBudgetSuccess()),
    );
  }
}
