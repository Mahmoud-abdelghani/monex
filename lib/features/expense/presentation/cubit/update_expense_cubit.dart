import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/expense/domain/usecase/update_expense_use_case.dart';

part 'update_expense_state.dart';

class UpdateExpenseCubit extends Cubit<UpdateExpenseState> {
  UpdateExpenseCubit(this.updateExpenseUseCase) : super(UpdateExpenseInitial());
  final UpdateExpenseUseCase updateExpenseUseCase;

  Future<void> updateExpense(ExpenseEntity expense) async {
    emit(UpdateExpenseLoading());
    final result = await updateExpenseUseCase.call(expense: expense);
    result.fold(
      (failure) => emit(UpdateExpenseFailure(failure.message)),
      (_) => emit(UpdateExpenseSuccess()),
    );
  }
}
