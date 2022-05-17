import 'dart:math';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/src/lottie_builder.dart';

import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/reward/reward_service_interface.dart';

@Injectable(as: IRewardService)
class RewardService implements IRewardService {
  bool _display = false;
  final Random random = Random();
  LottieBuilder _lottie;
  List<String> selectedValue0to3 = [
    'https://assets2.lottiefiles.com/packages/lf20_otic4zzq.json',
    'https://assets9.lottiefiles.com/packages/lf20_krS59y.json',
    'https://assets3.lottiefiles.com/private_files/lf30_FbH5Pa.json',
    'https://assets3.lottiefiles.com/packages/lf20_IWaVGJ.json',
    'https://assets3.lottiefiles.com/packages/lf20_9YfuEE.json',
    'https://assets2.lottiefiles.com/private_files/lf30_VeGYYQ.json',
    'https://assets8.lottiefiles.com/packages/lf20_yMnQ7s.json',
    'https://assets10.lottiefiles.com/packages/lf20_AdKXsL.json',
    'https://assets10.lottiefiles.com/packages/lf20_H1ntdl.json',
    'https://assets9.lottiefiles.com/packages/lf20_iZPjKM.json',
    'https://assets5.lottiefiles.com/packages/lf20_7vSLKj.json',
    'https://assets8.lottiefiles.com/private_files/lf30_1dN9on.json',
    'https://assets7.lottiefiles.com/packages/lf20_mflZYh.json',
    'https://assets7.lottiefiles.com/private_files/lf30_nKQAQr.json',
    'https://assets8.lottiefiles.com/private_files/lf30_mozscD.json',
    'https://assets2.lottiefiles.com/packages/lf20_7e8wRB.json'
        'https://assets2.lottiefiles.com/packages/lf20_7Tr0jX.json'
  ];

  List<String> lastThreeAndNegativeAnswer = [
    'https://assets2.lottiefiles.com/packages/lf20_ktn334ho.json',
    'https://assets4.lottiefiles.com/private_files/lf30_hFncuO.json',
    'https://assets8.lottiefiles.com/packages/lf20_wsiykzw8.json',
    'https://assets8.lottiefiles.com/packages/lf20_qpv5nu.json',
    'https://assets4.lottiefiles.com/packages/lf20_0FBZ1b.json',
    'https://assets7.lottiefiles.com/packages/lf20_ts8SWt.json',
    'https://assets3.lottiefiles.com/packages/lf20_wXbbg1.json',
    'https://assets1.lottiefiles.com/datafiles/qFkEay0GVjEXOof.json',
    'https://assets8.lottiefiles.com/datafiles/s2s8nJzgDOVLOcz.json',
    'https://assets9.lottiefiles.com/datafiles/4REnKJixS5dJP42.json',
    'https://assets2.lottiefiles.com/packages/lf20_jpzboilk.json',
    'https://assets4.lottiefiles.com/packages/lf20_sEoe0f.json',
    'https://assets6.lottiefiles.com/packages/lf20_PKEQzf.json',
  ];

  // List<String> selectedValue4to6 = [
  //   'https://assets2.lottiefiles.com/packages/lf20_ktn334ho.json',
  //   'https://assets4.lottiefiles.com/private_files/lf30_hFncuO.json',
  //   'https://assets8.lottiefiles.com/packages/lf20_wsiykzw8.json',
  //   'https://assets8.lottiefiles.com/packages/lf20_qpv5nu.json',
  //   'https://assets4.lottiefiles.com/packages/lf20_0FBZ1b.json',
  //   'https://assets7.lottiefiles.com/packages/lf20_ts8SWt.json',
  //   'https://assets3.lottiefiles.com/packages/lf20_wXbbg1.json',
  //   'https://assets1.lottiefiles.com/datafiles/qFkEay0GVjEXOof/data.json',
  //   'https://assets8.lottiefiles.com/datafiles/s2s8nJzgDOVLOcz/data.json',
  //   'https://assets9.lottiefiles.com/datafiles/4REnKJixS5dJP42/data.json'
  // ];

  // List<String> selectedValue7to10 = [
  //   'https://assets2.lottiefiles.com/packages/lf20_jpzboilk.json',
  //   'https://assets4.lottiefiles.com/packages/lf20_sEoe0f.json',
  //   'https://assets6.lottiefiles.com/packages/lf20_PKEQzf.json',
  // ];

  @override
  void displayAnimation(Activity activity, SurveyResponse response) {
    if (activity.name == 'pain') {
      if (response.selectedValue <= 2) {
        _lottie = Lottie.asset(
            getLottieAsset(
                selectedValue0to3[random.nextInt(selectedValue0to3.length)]),
            fit: BoxFit.contain);
      } else if (response.selectedValue <= 6) {
        _lottie = Lottie.asset(
            getLottieAsset(lastThreeAndNegativeAnswer[
                random.nextInt(lastThreeAndNegativeAnswer.length)]),
            fit: BoxFit.contain);
      } else {
        _lottie = Lottie.asset(
            getLottieAsset(lastThreeAndNegativeAnswer[
                random.nextInt(lastThreeAndNegativeAnswer.length)]),
            fit: BoxFit.contain);
      }
    } else if (activity.scale == 'yes_no') {
      if (response.selectedValue == 1) {
        _lottie = Lottie.asset(
            getLottieAsset(
                selectedValue0to3[random.nextInt(selectedValue0to3.length)]),
            fit: BoxFit.contain);
      } else {
        _lottie = Lottie.asset(
            getLottieAsset(lastThreeAndNegativeAnswer[
                random.nextInt(lastThreeAndNegativeAnswer.length)]),
            fit: BoxFit.contain);
      }
    } else {
      if (response.selectedValue <= 2) {
        _lottie = Lottie.asset(
            getLottieAsset(
                selectedValue0to3[random.nextInt(selectedValue0to3.length)]),
            fit: BoxFit.contain);
      } else {
        _lottie = Lottie.asset(
            getLottieAsset(lastThreeAndNegativeAnswer[
                random.nextInt(lastThreeAndNegativeAnswer.length)]),
            fit: BoxFit.contain);
      }
    }
    _display = !_display;
  }

  String getLottieAsset(String url) {
    final split = url.split('/');
    final fileName = split[split.length - 1];
    return 'assets/lotties/$fileName';
  }

  @override
  bool get showAnimation => _display;

  @override
  LottieBuilder get lottie => _lottie;
}
