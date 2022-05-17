import 'package:flutter/foundation.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey_response.dart';

abstract class IMilestoneService {
  Stream<List<Milestone>> loadMilestoneSourvey();
  Future<Null> registerMilestoneCompletion(
      {@required Milestone milestone, @required SurveyResponse surveyResponse});
  Map<String, dynamic> buildSurveyResponse(
      {Milestone milestone, SurveyResponse response});
  Future<void> resetMilestoneSurvey();
}
