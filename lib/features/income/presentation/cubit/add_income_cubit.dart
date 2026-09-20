import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';
import 'package:monex/features/income/domain/usecase/add_income_usecase.dart';

part 'add_income_state.dart';

class AddIncomeCubit extends Cubit<AddIncomeState> {
  AddIncomeCubit(this.addIncomeUsecase) : super(AddIncomeInitial());
  final AddIncomeUsecase addIncomeUsecase;

  Future<void> addIncome({
    required String title,
    required String method,
    required double amount,
    required String userId,
    required String categoryId,
    required DateTime date,
  }) async {

    final response = await addIncomeUsecase(
      title: title,
      method: method,
      amount: amount,
      userId: userId,
      categoryId: categoryId,
      date: date,
    );
    response.fold((l) => emit(AddIncomeFailure(l.message)), (r) => emit(AddIncomeSuccess()));
  }
}
