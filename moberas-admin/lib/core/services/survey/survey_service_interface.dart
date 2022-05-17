import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/milestone.dart';

abstract class ISurveyService {
  Stream<Activity> get activity$;
  Stream<List<Milestone>> get milestoneList$;
  Future<void> triggerDynamicSurvey(String hours);
  
  Future<void> showMilestoneSurvey();
  Future<void> dismissMilestoneSurvey();
}
