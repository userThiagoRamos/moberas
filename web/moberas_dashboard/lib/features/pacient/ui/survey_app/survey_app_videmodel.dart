import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/pacient/models/survey_app_model.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:stacked/stacked.dart';

class SurveyAppViewModel extends FutureViewModel<SurveyAppModel> {
  ///users/58I1ubos6Ng3ZFOW3EBiJOh7aAq1/private_profile/58I1ubos6Ng3ZFOW3EBiJOh7aAq1/user_experience_survey/fGZjIlrGCFJMR0eiDgH4
  UserProfile selectedPacient;

  SurveyAppViewModel(this.selectedPacient);
  @override
  Future<SurveyAppModel> futureToRun() async => _fetchSurvey();

  Future<SurveyAppModel> _fetchSurvey() async {
    final surveyList = await Collection<SurveyAppModel>(
            path:
                'users/${selectedPacient.uid}/private_profile/${selectedPacient.uid}/user_experience_survey')
        .getData();
    if (surveyList.isNotEmpty) {
      return surveyList[0];
    } else {
      return null;
    }
  }

  @override
  void onError(error) {
    print(error);
    super.onError(error);
  }
}
