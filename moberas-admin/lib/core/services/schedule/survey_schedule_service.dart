import 'dart:isolate';
import 'dart:ui';
import 'package:pedantic/pedantic.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:bringtoforeground/bringtoforeground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/globals.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';

const String isolateName = 'isolate';
int contCall = 0;

@Singleton()
class SurveyScheduleService {


  SurveyScheduleService(this._surveyService);
  final ISurveyService _surveyService;

  int contFunc = 0;

  final ReceivePort port = ReceivePort();

  void registerPortName() => IsolateNameServer.registerPortWithName(
        port.sendPort,
        isolateName,
      );

  void initializaAlarmManager() async => await AndroidAlarmManager.initialize();

  Future<void> scheduleAlamars() async {
    try {
      print('entrou no cron job - ');
      await AndroidAlarmManager.periodic(Duration(minutes: 1), 0, callback,
          rescheduleOnReboot: true, wakeup: true, exact: true);
    } catch (e) {
      print('cronJos error ${e.toString()}');
    }
  }

  static SendPort uiSendPort;

  static Future<void> callback() async {
    print('callback! - ${contCall++}');
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    Bringtoforeground.bringAppToForeground();
    uiSendPort?.send(null);
  }

  Future<void> setCallback() async => port
      .asBroadcastStream()
      .listen((_) async => await _triggerDynamicSurvey(), cancelOnError: false);

  void _triggerDynamicSurvey() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null) {
      final now = DateTime.now();
      final minutes = now.minute;
      String hours = '';

      print('port listerner + ${contFunc}');

      if (Global.eightHoursSchedule.contains(now.hour) && minutes == 0) {
        hours = '8 horas';
      } else if (Global.fourHoursSchedule.contains(now.hour) && minutes == 0) {
        hours = '4 horas';
      }
      if (hours.isNotEmpty) {
        unawaited(_surveyService.triggerDynamicSurvey(hours));
      }
    }
  }

  Future<void> setup() async {
    registerPortName();
    initializaAlarmManager();
    await setCallback();
    await scheduleAlamars();
  }
}
