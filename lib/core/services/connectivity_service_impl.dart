import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:monex/core/services/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity connectivity;

  ConnectivityServiceImpl(this.connectivity);
  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.any((element) => element != ConnectivityResult.none);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return connectivity.onConnectivityChanged.map(
      (event) => event.any((element) => element != ConnectivityResult.none),
    );
  }
}
