import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/pedometer/pedometer_service.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:pedometer/pedometer.dart';

@Singleton(as: PedometerService)
class PedometerServiceImpl implements PedometerService {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  final ProfileService _profileService = locator<ProfileService>();

  @override
  String get steps => _steps;

  void onPedestrianStatusError(error) {
    _status = 'Pedestrian Status not available';
  }

  void onStepCountError(error) {
    _steps = 'Step Count not available';
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    _status = event.status;
  }

  void onStepCount(StepCount event) {
    _steps = event.steps.toString();
    _profileService.registerSteps(event.steps);
  }

  @override
  void init() {
    try {
      // _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      // _pedestrianStatusStream
      //     .listen(onPedestrianStatusChanged)
      //     .onError(onPedestrianStatusError);
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    } catch (e) {
      print(e);
    }
  }
}
