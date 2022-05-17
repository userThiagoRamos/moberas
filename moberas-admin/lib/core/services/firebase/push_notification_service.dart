import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/messages/pacient_message_interface.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:mobEras/core/utils/logger.dart';

@Singleton()
class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  final ProfileService _profileService = locator<ProfileService>();
  final _surveyService = locator<ISurveyService>();
  
  PushNotificationService() {
    _fcm.onTokenRefresh.listen(_updateUserToken);
  }

  Future init() async {
    try {
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          await _mobErasMessageHandler(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          await _mobErasMessageHandler(message);
        },
        onResume: (Map<String, dynamic> message) async {
          await _mobErasMessageHandler(message);
        },
        onBackgroundMessage: mobErasBackgroundMessageHandler,
      );
    } catch (e) {
      Logger.e('init push service $e', e: e);
    }
  }

  static Future<dynamic> mobErasBackgroundMessageHandler(Map<String, dynamic> message) async {
    print('chegou msg backgroud');
    final dynamic data = message['data'];
    var hour = data['hour'];
    if (hour != null) {
      await locator<ISurveyService>().triggerDynamicSurvey(hour);
    }
  }

  Future<void> _mobErasMessageHandler(Map<String, dynamic> message) async {
    var data = message['data'];
    var hour = data['hour'];
    if (hour != null) {
      await _showSurvey(hour);
    }
  }

  Future<void> _showSurvey(hour) async {
    await _surveyService.triggerDynamicSurvey(hour);
  }

  Future<void> _updateUserToken(String event) async {
    await _profileService.registerFCMToken(event);
  }
}
