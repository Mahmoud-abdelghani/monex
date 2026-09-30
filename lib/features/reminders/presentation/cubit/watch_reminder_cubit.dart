import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/usecases/watch_reminder_usecase.dart';

part 'watch_reminder_state.dart';

class WatchReminderCubit extends Cubit<WatchReminderState> {
  WatchReminderCubit(this.watchReminderUsecase) : super(WatchReminderInitial());
  final WatchReminderUsecase watchReminderUsecase;
  StreamSubscription? _streamSubscription;

  Future<void> watchReminders() async {
    _streamSubscription?.cancel();
    _streamSubscription = watchReminderUsecase().listen((event) {
      event.fold(
        (l) => emit(WatchReminderFailure(l.message)),
        (reminders) => emit(WatchReminderSuccess(reminders)),
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
