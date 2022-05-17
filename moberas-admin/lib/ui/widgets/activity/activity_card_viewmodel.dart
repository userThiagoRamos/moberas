import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:lottie/lottie.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/activity/activity_service.dart';
import 'package:mobEras/core/services/audio/audio_service.dart';
import 'package:mobEras/core/services/messages/pacient_message_interface.dart';
import 'package:mobEras/core/services/reward/reward_service_interface.dart';
import 'package:mobEras/core/services/scale/IScaleService.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';

class ActivityCardViewModel extends FutureViewModel {
  ActivityCardViewModel(Activity activity) {
    _activity = activity;
    if (_activity.name == 'intro') {
      startTimer();
    } else {
      try {
        unawaited(_audioService.stop());
        if (audioAlarmTimer != null) {
          audioAlarmTimer.cancel();
        }
      } catch (e) {
        unawaited(_audioService.stop());
        Logger.e('activityCardConstructor', e: e);
      }
    }
  }

  Timer audioAlarmTimer;
  Timer rewardTimer;

  Activity _activity;
  final IActivityService _activityService = locator<IActivityService>();
  final _imageLabelCache = <String, String>{};
  final IRewardService _rewardService = locator<IRewardService>();
  final IScaleService _scaleService = locator<IScaleService>();
  final IPacientMessageService msgService = locator<IPacientMessageService>();
  final AudioService _audioService = locator<AudioService>();
  bool _showReward = false;

  @override
  Future futureToRun() => _scaleService.getScaleImageMap(_activity.scale);

  @override
  void dispose() {
    if (audioAlarmTimer != null) {
      audioAlarmTimer.cancel();
    }
    unawaited(_audioService.stop());
    super.dispose();
  }

  LottieBuilder get lottie => _rewardService.lottie;

  bool get showReward => _showReward;

  void registerAnswer({Activity activity, SurveyResponse response}) {
    _audioService.answered();
    _rewardService.displayAnimation(activity, response);
    _showReward = !_showReward;
    notifyListeners();
    rewardTimer = Timer(Duration(seconds: 2), () {
      unawaited(_activityService.registerActivityCompletion(activity: activity, response: response));
      _showReward = !_showReward;
    });
  }

  String getImgDescription(String imageName) {
    var imageLabel;
    if (_imageLabelCache.containsValue(imageName)) {
      imageLabel = _imageLabelCache[imageName];
    } else {
      var splitedImageName = imageName.split('_');
      imageLabel = splitedImageName[1].replaceAll('.png', '');
      _imageLabelCache.putIfAbsent(imageName, () => imageLabel);
    }

    return imageLabel;
  }

  int getSelectedValue(String imageName) {
    var splitedImageName = imageName.split('_');
    return int.tryParse(splitedImageName[0]);
  }

  void dismissIntro({@required Activity activity}) async {
    await runBusyFuture(
      _activityService.registerActivityCompletion(
        activity: activity,
        response: SurveyResponse(
          selectedValue: 0,
          dateTime: DateTime.now(),
        ),
      ),
    );
    audioAlarmTimer.cancel();
    unawaited(_audioService.stop());
  }

  void startTimer() {
    audioAlarmTimer = Timer.periodic(Duration(seconds: 5), warnPacient);
  }

  void warnPacient(Timer timer) async {
    if (_activity != null && _activity.name != 'intro') {
      timer.cancel();
      unawaited(_audioService.stop());
    } else {
      unawaited(_audioService.taskIni());
    }
  }
}
