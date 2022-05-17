import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/user_location.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';

@Injectable(as: ProfileService)
class ProfileServiceImpl implements ProfileService {
  String get date => DateFormat('dd/MM/y').format(Timestamp.now().toDate());
  String get dateTime => DateFormat('dd/MM/y hh:mm:ss:mmm' ).format(Timestamp.now().toDate());

  @override
  Future<void> registerUserLocation(UserLocation location) async {
    try {
      var geoPoint = GeoPoint(location.latitude, location.longitude);
      unawaited(UserProfileData().upsert({
        'locations': {dateTime: geoPoint}
      }));
    } catch (e) {
      Logger.e('registerlocation', e: e);
    }
  }

  @override
  Future<void> registerUserLoginLocation(UserLocation location) async {
    var geoPoint = GeoPoint(location.latitude, location.longitude);
    return UserProfileData().upsert({'loginLocation': geoPoint});
  }

  @override
  Future<void> setUserOnlineStatus(bool online) async =>
      UserProfileData().upsert({'online': online});

  @override
  Future<void> registerSteps(int steps) async {
    if (steps > 0) {
      await UserProfileData().upsert({
        'steps': {date: steps}
      });
    }
  }



  @override
  Future<void> registerFCMToken(String token) async {
    await UserProfileData().upsert({'fcmToken': token});
  }
}
