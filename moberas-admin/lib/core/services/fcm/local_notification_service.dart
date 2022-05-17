import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';

@singleton
class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin => _flutterLocalNotificationsPlugin;

  MethodChannel platform = MethodChannel('com.moberas/moberas');

  Future<void> initializeLocalNotifications() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> createNotificationChannel() async {
    var androidNotificationChannel = AndroidNotificationChannel(
      'moberas_survey',
      'moberas_survey',
      'moberas_survey',
      playSound: true,
      enableLights: true,
      enableVibration: true,
      showBadge: true,
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('fcm_alarm'),
    );
  
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);
  }
}
