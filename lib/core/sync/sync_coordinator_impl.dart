import 'dart:async';

import 'package:monex/core/services/connectivity_service.dart';
import 'package:monex/core/sync/sync_coordinator.dart';
import 'package:monex/core/usecase/sync_usecase.dart';

class SyncCoordinatorImpl implements SyncCoordinator {
  final SyncUsecase syncUsecase;
  final ConnectivityService connectivityService;

  SyncCoordinatorImpl(this.connectivityService, this.syncUsecase);

  bool? wasConnected;
  StreamSubscription<bool>? subscription;
  @override
  Future<void> dispose() async {
    await subscription?.cancel();
    subscription = null;
  }

  @override
  Future<void> start() async {
    wasConnected = await connectivityService.isConnected;
    subscription = connectivityService.onConnectivityChanged.listen(
      onConnected,
    );
  }

  Future<void> onConnected(bool isConnected) async {
    if (isConnected && wasConnected == false) await syncUsecase();
    wasConnected = isConnected;
  }
}
