import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/domain/usecases/add_reminder_usecase.dart';

part 'add_reminder_state.dart';

class AddReminderCubit extends Cubit<AddReminderState> {
  AddReminderCubit(this.addReminderUsecase) : super(AddReminderInitial());
  final AddReminderUsecase addReminderUsecase;

  Future<void> addreminder({
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
    required DateTime scheduleDate,
  }) async {
    emit(AddReminderLoading());
    final result = await addReminderUsecase(

      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
      scheduleDate: scheduleDate
    );
    result.fold(
      (l) => emit(AddReminderFailure(l.message)),
      (r) => emit(AddReminderSuccess()),
    );
  }
}
