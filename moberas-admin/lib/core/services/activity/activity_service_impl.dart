import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/globals.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/activity/activity_service.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_services/stacked_services.dart';

@Injectable(as: IActivityService)
class ActivityServiceImpl implements IActivityService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final NavigationService _navService = locator<NavigationService>();

  @override
  Stream<Activity> loadActivititySourvey() => _fecthCurrentActivity();

  @override
  Future<void> registerActivityCompletion(
      {Activity activity, SurveyResponse response}) async {
    final user = await _firebaseAuth.currentUser();
    if (user != null) {
      final data = buildSurveyResponse(
          activity: activity, response: response, user: user);
      final newDocId = getRandomId();
      await _insertAnswer(user, newDocId, data);
      await setDisplayOff(user, activity);
      await _analyticsService.logActivityAnswer(data);
    }
  }

  @override
  Map<String, Object> buildSurveyResponse(
      {Activity activity, SurveyResponse response, FirebaseUser user}) {
    return {
      'activity': activity.name,
      'response_value': response.selectedValue,
      'response_user_uid': user.uid,
      'response_date': Timestamp.now()
    };
  }

  Future _insertAnswer(
      FirebaseUser user, String newDocId, Map<String, Object> data) async {
    await Document<Activity>(
            path:
                '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities_responses/${newDocId}')
        .upsert(data);
  }

  ///Busca a atividade para exibicao no questionario dinamico.A pergunta que sera é exibida possui o atrituto 'display = true'
  Stream<Activity> _fecthCurrentActivity() {
    return _firebaseAuth.onAuthStateChanged.switchMap((user) => user != null
        ? Collection<Activity>(
                path:
                    '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities')
            .ref
            .where('display', isEqualTo: true)
            .orderBy('order', descending: false)
            .limit(1)
            .snapshots()
            .map((querySnapshot) => Global.models[Activity](
                querySnapshot.documents[0].data,
                querySnapshot.documents[0].documentID) as Activity)
        : Stream<Activity>.value(null));
  }

  Future setDisplayOff(FirebaseUser user, Activity activity) async {
    try {
      var order = activity.order + 1;
      await Document<Activity>(
              path:
                  '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities/${activity.id}')
          .upsert({'display': false});

      var docs = await Collection<Activity>(
              path:
                  '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities/')
          .ref
          .where('order', isEqualTo: order)
          .limit(1)
          .getDocuments();
      if (docExists(docs)) {
        await docs.documents[0].reference
            .setData({'display': true}, merge: true);
        if (docs.documents[0].data['name'] == 'final') {
          setDisplayTimer();
        }
      }
    } catch (e) {
      Logger.e('setDiaplyOff', e: e);
    }
  }

  bool docExists(QuerySnapshot docs) {
    return docs != null &&
        docs.documents.isNotEmpty &&
        docs.documents[0].exists;
  }

  void setDisplayTimer() {
    Timer(Duration(seconds: 10), dismissCongratsCard);
  }

  void dismissCongratsCard() async {
    try {
      var user = await _firebaseAuth.currentUser();

      await Document<Activity>(
              path:
                  '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities/final')
          .upsert({'display': false});
      await Document<Activity>(
              path:
                  '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}')
          .upsert({'dynamicOnDisplay': false});
      await _analyticsService.logSurveyDynamicEnd({'uid': user.uid});
      await _navService.navigateTo(Routes.milestoneSurveyView);
    } catch (e) {
      Logger.e('dismissCongrats', e: e);
    }
  }

  @override
  void dismiss(Activity activity) {
    _firebaseAuth.currentUser().then((user) => Document<Activity>(
            path:
                '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/activities/${activity.id}')
        .upsert({'display': false}));
  }
}
