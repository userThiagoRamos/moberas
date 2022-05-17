import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/constants/moberas_analytics.dart';
import 'package:mobEras/core/utils/logger.dart';

@Singleton()
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({@required String userId, String email}) async {
    try {
      await _analytics.setUserId(userId);
      await _analytics.setUserProperty(name: 'email', value: email);
    } catch (e) {
      Logger.e('setUserProperties', e: e);
    }
  }

  Future logLogin() async {
    await _analytics.logLogin(loginMethod: 'email');
  }

  Future logSignUp(String method) async {
    try {
      await _analytics.logSignUp(signUpMethod: method);
    } catch (e) {
      Logger.e('loginSignup $e', e: e);
    }
  }

  Future logMilestoneAnswer(Map<String, dynamic> parameters) async {
    try {
      parameters.remove('response_date');
      await _analytics.logEvent(
          name: MobErasAnalytics.milestone_answer, parameters: {...parameters});
    } catch (e) {
      Logger.e('logMilestoneAnswer $e', e: e);
    }
  }

  Future logActivityAnswer(Map<String, dynamic> params) async {
    try {
      params.remove('response_date');
      await _analytics.logEvent(
        name: MobErasAnalytics.activity_answer,
        parameters: {...params},
      );
    } catch (e) {
      Logger.e('logActivityAnswer $e', e: e);
    }
  }

  Future logSurveyDynamicStart(Map<String, dynamic> params) async {
    try {
      await _analytics.logEvent(
        name: MobErasAnalytics.survey_dynamic_start,
        parameters: {...params},
      );
    } catch (e) {
      Logger.e('logSurveyDynamicStart $e', e: e);
    }
  }

  Future logSurveyMilestoneStart(Map<String, dynamic> params) async {
    try {
      await _analytics.logEvent(
        name: MobErasAnalytics.survey_milestone_start,
        parameters: {...params},
      );
    } catch (e) {
      Logger.e('logSurveyMilestoneStart $e', e: e);
    }
  }

  Future logSurveyDynamicEnd(Map<String, dynamic> params) async {
    try {
      await _analytics.logEvent(
        name: MobErasAnalytics.survey_dynamic_end,
        parameters: {...params},
      );
    } catch (e) {
      Logger.e('logSurveyDynamicEnd $e', e: e);
    }
  }

  Future logSurveyMilestoneEnd(Map<String, dynamic> params) async {
    try {
      await _analytics.logEvent(
        name: MobErasAnalytics.survey_milestone_end,
        parameters: {...params},
      );
    } catch (e) {
      Logger.e('logSurveyMilestoneEnd $e', e: e);
    }
  }
}
