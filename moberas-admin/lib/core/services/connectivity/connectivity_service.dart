import 'package:mobEras/core/enums/connectivity_status.dart';
import 'package:mobEras/core/services/stoppable_service.dart';

abstract class ConnectivityService implements StoppableService {
  Stream<ConnectivityStatus> get connectivity$;

  Future<bool> get isConnected;
}
