import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:mobEras/core/services/milestone/milestone_service_interface.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: IMilestoneService)
class MilestoneService implements IMilestoneService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  @override
  Future<Null> registerMilestoneCompletion(
      {Milestone milestone, SurveyResponse surveyResponse}) async {
    try {
      final user = await _firebaseAuth.currentUser();
      if (user != null) {
        final data =
            buildSurveyResponse(milestone: milestone, response: surveyResponse);
        final newDocId = getRandomId();
        await _insertAnswer(user, newDocId, data);
        await _setDisplayOff(user, milestone);
        unawaited(_analyticsService.logMilestoneAnswer(data));
      }
    } catch (e) {
      Logger.e('registerMilestoneCompletion', e: e);
    }
  }

  @override
  Stream<List<Milestone>> loadMilestoneSourvey() {
    return _firebaseAuth.onAuthStateChanged.switchMap((user) => user != null
        ? Collection<Milestone>(
                path:
                    '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/milestones')
            .ref
            .where('display', isEqualTo: true)
            .snapshots()
            .map(
              (querySnapshot) => querySnapshot.documents
                  .map(
                    (docSnapshot) => Milestone.fromData(
                        docSnapshot.data, docSnapshot.documentID),
                  )
                  .toList(),
            )
        : Stream<List<Milestone>>.empty());
  }

  @override
  Map<String, dynamic> buildSurveyResponse(
      {Milestone milestone, SurveyResponse response}) {
    return {'milestone': milestone.name, 'response_date': response.dateTime};
  }

  Future _insertAnswer(
      FirebaseUser user, String newDocId, Map<String, Object> data) async {
    await Document<Milestone>(
            path:
                '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/milestone_responses/${newDocId}')
        .upsert(data);
  }

  Future _setDisplayOff(FirebaseUser user, Milestone milestone) async {
    await Document<Milestone>(
            path:
                '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/milestones/${milestone.id}')
        .upsert({'display': false});
  }

  @override
  Future<void> resetMilestoneSurvey() async {
    final fbAuth = FirebaseAuth.instance;
    final user = await fbAuth.currentUser();
    if (user != null) {
      var querySnapshot = await Collection<Milestone>(
              path:
                  '/users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}/milestones')
          .ref
          .where('display', isEqualTo: false)
          .getDocuments();
      if (querySnapshot.documents.isNotEmpty) {
        querySnapshot.documents.forEach((doc) {
          doc.reference.updateData({'display': true});
        });
      }
    }
  }
}
