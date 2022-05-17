import 'package:mobEras/core/services/messages/pacient_message_interface.dart';
import 'package:bringtoforeground/bringtoforeground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/activity/activity_service.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:mobEras/core/services/milestone/milestone_service_interface.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_services/stacked_services.dart';

enum SurveyState { hasMilestone, hasDynamic, idle }

@Injectable(as: ISurveyService)
class SurveyService implements ISurveyService {
  final IMilestoneService _milestoneService = locator<IMilestoneService>();
  final IActivityService _activityService = locator<IActivityService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final _navService = locator<NavigationService>();
  final IPacientMessageService _pacientMsgService = locator<IPacientMessageService>();

  @override
  Stream<Activity> get activity$ =>
      UserSurveyStatus().streamData().switchMap((surveyStatus) => surveyStatus.dynamicOnDisplay ? _activityService.loadActivititySourvey() : Stream<Activity>.empty());

  @override
  Stream<List<Milestone>> get milestoneList$ =>
      UserSurveyStatus().streamData().switchMap((surveyStatus) => surveyStatus.milestoneOnDisplay ? _milestoneService.loadMilestoneSourvey() : Stream<List<Milestone>>.empty());

  @override
  Future<void> triggerDynamicSurvey(String hours) async {
    var ref = await UserSurveyStatus().getDocumentRef();
    await ref.setData({'dynamicOnDisplay': true}, merge: true);
    final user = await FirebaseAuth.instance.currentUser();
    unawaited(_analyticsService.logSurveyDynamicStart({'uid': user.uid}));
    _pacientMsgService.hours = hours;
    await _navService.navigateTo(Routes.dynamicSurveyView);
  }

  @override
  Future<void> showMilestoneSurvey() async {
    var ref = await UserSurveyStatus().getDocumentRef();
    await ref.setData({'milestoneOnDisplay': true}, merge: true);
    final user = await FirebaseAuth.instance.currentUser();
    unawaited(_analyticsService.logSurveyMilestoneStart({'uid': user.uid}));
    
  }



  @override
  Future<void> dismissMilestoneSurvey() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      unawaited(_analyticsService.logSurveyMilestoneEnd({'uid': user.uid}));
      unawaited(Document<Milestone>(path: '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}').upsert({'milestoneOnDisplay': false}));
    }
  }
}
