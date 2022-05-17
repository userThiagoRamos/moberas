import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/services/messages/pacient_message_interface.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:stacked/stacked.dart';

class DynamicSurveyViewModel extends StreamViewModel<Activity> {
  final ISurveyService _sourveyService = locator<ISurveyService>();
  final IPacientMessageService msgService = locator<IPacientMessageService>();

  @override
  Stream<Activity> get stream => _sourveyService.activity$;
}
