import 'package:flutter/foundation.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';

abstract class IActivityService {
  Stream<Activity> loadActivititySourvey();
  Future<void> registerActivityCompletion(
      {@required Activity activity, @required SurveyResponse response});
  Map<String, Object> buildSurveyResponse(
      {Activity activity, SurveyResponse response});

  void dismiss(Activity activity) {}
}
