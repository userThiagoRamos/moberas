import 'package:mobEras/core/models/user_location.dart';
import 'package:mobEras/core/services/stoppable_service.dart';

abstract class LocationService implements StoppableService {
  Stream<UserLocation> get location$;

  /// Fetch the current location | `null` is permission was denied
  Future<void> registerLocation();
}
