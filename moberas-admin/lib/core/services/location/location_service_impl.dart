import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/user_location.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';

import 'location_service.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  var location = Location();
  StreamSubscription<LocationData> _locationSubscription;
  final _locationController = StreamController<UserLocation>();
  final ProfileService _profileService = locator<ProfileService>();

  bool _serviceStopped = false;

  @override
  Future<void> registerLocation() => location.getLocation().then((location) => _registerUserLocation(location)).catchError((e) => Logger.e('getLocation', e: e.messsa));

  @override
  Stream<UserLocation> get location$ => _locationController.stream;

  @override
  bool get serviceStopped => _serviceStopped;

  @override
  void start() async {
    _serviceStopped = false;
    if (_locationSubscription == null) {
      await _listenToLocationStream();
    } else {
      _locationSubscription.resume();
    }
    Logger.d('Location Service Started ${!serviceStopped}');
  }

  @override
  void stop() {
    _serviceStopped = true;
    if (_locationSubscription != null) {
      _locationSubscription.pause();
    }
    Logger.d('Location Service Stopped $serviceStopped');
  }

  Future<void> _listenToLocationStream() async {
    await location.changeSettings(accuracy: LocationAccuracy.high,distanceFilter: 3.0);
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _locationSubscription = location.onLocationChanged.where((locWh) => locWh != null).listen((locationData) {
        var userLocation = UserLocation(latitude: locationData.latitude, longitude: locationData.longitude);
        unawaited(_profileService.registerUserLocation(userLocation));
        _locationController.add(
          userLocation,
        );
      });
    }
  }

  void _registerUserLocation(LocationData location) {
    try {
      var userLocation = UserLocation(latitude: location.latitude, longitude: location.longitude);
      unawaited(_profileService.registerUserLoginLocation(userLocation));
    } catch (e) {
      Logger.e('registerUserLocation', e: e);
    }
  }
}
