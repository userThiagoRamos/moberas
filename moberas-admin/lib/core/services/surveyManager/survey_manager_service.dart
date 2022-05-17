import 'package:bringtoforeground/bringtoforeground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/survey_status_model.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../firestore_data_wrapper.dart';

@Singleton()
class SurveyManagerService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ISurveyService _surveyService = locator<ISurveyService>();
  final _navService = locator<NavigationService>();

  SurveyManagerService() {
    dynamicSurveyManager$.listen((data) => handleDynamicSurvey(data));
  }

  Stream<SurveyStatusModel> _getDynamicSurveyManager() {
    return _firebaseAuth.onAuthStateChanged.switchMap((user) {
      if (user != null) {
        return Document<SurveyStatusModel>(path: 'users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}').streamData();
      } else {
        return Stream.value(SurveyStatusModel.defaultSurveyManager());
      }
    });
  }

  Stream<SurveyStatusModel> _getStaticSurveyManager() {
    return _firebaseAuth.onAuthStateChanged.switchMap((user) {
      if (user != null) {
        return Document<SurveyStatusModel>(path: 'users/${user.uid}/private_profile/${user.uid}/survey/${user.uid}').streamData();
      } else {
        return Stream.value(SurveyStatusModel.defaultSurveyManager());
      }
    });
  }

  Stream<SurveyStatusModel> get dynamicSurveyManager$ => _getDynamicSurveyManager();

  Stream<SurveyStatusModel> get staticSurveyManager$ => _getStaticSurveyManager();

  void handleDynamicSurvey(SurveyStatusModel event) {
    if (event.dynamicOnDisplay) {
      _surveyService.triggerDynamicSurvey('4 horas');
      _navService.navigateTo(Routes.milestoneSurveyView);
    }
  }
}
