import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/income/domain/usecase/update_income_usecase.dart';

part 'update_income_state.dart';

class UpdateIncomeCubit extends Cubit<UpdateIncomeState> {
  UpdateIncomeCubit(this.updateIncomeUsecase) : super(UpdateIncomeInitial());
  final UpdateIncomeUsecase updateIncomeUsecase;

  Future<void> updateIncome({
    required String title,
    required String id,
    required String method,
    required double amount,
    required String userId,
    required String categoryId,
    required DateTime date,
  }) async {
    emit(UpdateIncomeLoading());
    final response = await updateIncomeUsecase(
      title: title,
      id: id,
      method: method,
      amount: amount,
      userId: userId,
      categoryId: categoryId,
      date: date,
    );
    response.fold(
      (l) => emit(UpdateIncomeFailure(l.message)),
      (r) => emit(UpdateIncomeSuccess()),
    );
  }
}
