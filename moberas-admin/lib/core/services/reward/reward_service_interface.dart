import 'package:lottie/lottie.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';

abstract class IRewardService {
  void displayAnimation(Activity activity, SurveyResponse response);
  bool get showAnimation;
  LottieBuilder get lottie;
}
