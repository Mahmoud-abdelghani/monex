import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/usecases/get_reminder_by_id_usecase.dart';

part 'get_reminder_by_id_state.dart';

class GetReminderByIdCubit extends Cubit<GetReminderByIdState> {
  GetReminderByIdCubit(this.getReminderByIdUsecase) : super(GetReminderByIdInitial());
  final GetReminderByIdUsecase getReminderByIdUsecase;

  Future<void> getReminderById(String id) async {
    emit(GetReminderByIdLoading());
    final failureOrReminder = await getReminderByIdUsecase(id);
    failureOrReminder.fold(
      (failure) => emit(GetReminderByIdFailure(failure.message)),
      (reminder) => emit(GetReminderByIdSuccess(reminder)),
    );
  }
}
