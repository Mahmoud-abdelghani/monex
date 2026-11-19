import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/reminders/domain/usecases/reschdule_reminder_usecase.dart';

part 'reschedule_reminder_state.dart';

class RescheduleReminderCubit extends Cubit<RescheduleReminderState> {
  RescheduleReminderCubit(this.reschduleReminderUsecase)
    : super(RescheduleReminderInitial());
  final ReschduleReminderUsecase reschduleReminderUsecase;

  Future<void> reschedule(String reminderId) async {
    emit(RescheduleReminderLoading());
    final result = await reschduleReminderUsecase(reminderId);
    result.fold(
      (failure) => emit(RescheduleReminderFailure(failure.message)),
      (_) => emit(RescheduleReminderSuccess()),
    );
  }
}
