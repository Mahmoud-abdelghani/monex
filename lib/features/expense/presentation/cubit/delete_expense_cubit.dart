import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/expense/domain/usecase/delete_expense_use_case.dart';

part 'delete_expense_state.dart';

class DeleteExpenseCubit extends Cubit<DeleteExpenseState> {
  DeleteExpenseCubit(this.deleteExpenseUseCase) : super(DeleteExpenseInitial());
  final DeleteExpenseUseCase deleteExpenseUseCase;

  Future<void> deleteExpense(String expenseId) async {
    emit(DeleteExpenseLoading());
    final result = await deleteExpenseUseCase(expenseId);
    result.fold(
      (failure) => emit(DeleteExpenseFailure(failure.message)),
      (_) => emit(DeleteExpenseSuccess()),
    );
  }
}
