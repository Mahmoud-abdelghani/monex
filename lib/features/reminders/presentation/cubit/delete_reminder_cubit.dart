import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/reminders/domain/usecases/delete_reminder_usecase.dart';

part 'delete_reminder_state.dart';

class DeleteReminderCubit extends Cubit<DeleteReminderState> {
  DeleteReminderCubit(this.deleteReminderUsecase)
    : super(DeleteReminderInitial());
  final DeleteReminderUsecase deleteReminderUsecase;

  Future<void> deletereminder(String id) async {
    emit(DeleteReminderLoading());
    final result = await deleteReminderUsecase(id);
    result.fold(
      (l) => emit(DeleteReminderFailure(l.message)),
      (r) => emit(DeleteReminderSuccess()),
    );
  }
}
