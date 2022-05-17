import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/msgpanel/msg_panel_service_interface.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends StreamViewModel<String> {
  HomeViewModel() {
    // FlutterRingtonePlayer.stop();
  }
  final navService = locator<NavigationService>();
  final _surveyService = locator<ISurveyService>();
  final IMsgPanelService _msgPanelService = locator<IMsgPanelService>();
  String steps;

  final HttpsCallable callableMobErasPacientPush =
      CloudFunctions.instance.getHttpsCallable(
    functionName: 'pacientPush',
  );

  Future<void> showDynamicDisplay() async {
    await _surveyService.triggerDynamicSurvey('4 horas');
  }

  Future<void> sendMsg(String uid, String msg) async {
    try {
      var data = {'uid': uid, 'msg': msg};
      await callableMobErasPacientPush.call(data);
    } catch (e) {
      Logger.e('sendpush', e: e);
    }
  }

  Future<void> goToMilestone() async {
    await _surveyService.showMilestoneSurvey();
  }

  @override
  Stream<String> get stream => _msgPanelService.defaultMessage$;
}
