import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/domain/usecases/update_reminder_usecase.dart';

part 'update_reminder_state.dart';

class UpdateReminderCubit extends Cubit<UpdateReminderState> {
  UpdateReminderCubit(this.updateReminderUsecase)
    : super(UpdateReminderInitial());
  final UpdateReminderUsecase updateReminderUsecase;

  Future<void> updatereminder({
    required String id,
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime scheduleDate,
    required DateTime deadline,
  }) async {
    emit(UpdateReminderLoading());
    final result = await updateReminderUsecase(
      id: id,
      title: title,
      amount: amount,
      frequency: frequency,
      scheduleDate: scheduleDate,
      deadline: deadline,
    );
    result.fold(
      (l) => emit(UpdateReminderFailure(l.message)),
      (r) => emit(UpdateReminderSuccess()),
    );
  }
}
