import 'package:mobEras/core/models/user_location.dart';

abstract class ProfileService {
  Future<void> registerUserLocation(UserLocation userLocation);

  Future<void> registerUserLoginLocation(UserLocation location);

  Future<void> setUserOnlineStatus(bool online);

  Future<void> registerFCMToken(String token);

  void registerSteps(int event) {}
  
}
