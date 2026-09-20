import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/sync/sync_engine.dart';
import 'package:monex/core/usecase/pending_operation_usecase.dart';
import 'package:monex/core/usecase/sync_usecase.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this.retryOperationUsecase, this.syncUsecase)
    : super(SyncInitial());
  final RetryOperationUsecase retryOperationUsecase;
  final SyncUsecase syncUsecase;

  Future<void> retry(String operationId) async {
    emit(SyncLoading());

    final result = await retryOperationUsecase(operationId);

    final shouldSync = result.fold(
      (failure) {
        emit(SyncFailure(failure.message));
        return false;
      },
      (_) {
        return true;
      },
    );

    if (!shouldSync) return;

    try {
      await syncUsecase();
      emit(SyncSuccess());
    } catch (e) {
      emit(SyncFailure(e.toString()));
    }
  }
}
