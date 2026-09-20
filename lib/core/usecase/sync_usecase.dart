import 'package:monex/core/sync/sync_engine.dart';

class SyncUsecase {
  final SyncEngine syncEngine;
  SyncUsecase(this.syncEngine);

  Future<void> call() async => await syncEngine.sync();
}
