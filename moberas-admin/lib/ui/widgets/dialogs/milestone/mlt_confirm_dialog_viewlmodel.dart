import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/milestone/milestone_service_interface.dart';
import 'package:stacked/stacked.dart';

class MltConfirmDialogViewModel extends BaseViewModel {
  final IMilestoneService _milestoneService = locator<IMilestoneService>();

  String selectDay;
  String selectHour;
  List<bool> isDaySelected = [false, false, false];

  void defineSeleciont(String item) {
    selectDay = item;
    notifyListeners();
  }

  void defineSelecionHour(String item) {
    selectHour = item;
    notifyListeners();
  }

  void markDaySeletion(int index) {
    for (int buttonIndex = 0;
        buttonIndex < isDaySelected.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        isDaySelected[buttonIndex] = !isDaySelected[buttonIndex];
      } else {
        isDaySelected[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  Future<bool> registerResponse(
      {@required Milestone milestone, TimeOfDay time}) async {
    var dateTime = _getResponseDateTime();
    await _milestoneService.registerMilestoneCompletion(
        milestone: milestone,
        surveyResponse: SurveyResponse(dateTime: dateTime));
    return true;
  }

  DateTime _getResponseDateTime({TimeOfDay time}) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;
    if (selectHour != null) {
      minute = 00;
      switch (selectHour.toLowerCase().trim()) {
        case 'manhã':
          hour = 8;
          break;
        case 'tarde':
          hour = 13;
          break;
        case 'noite':
          hour = 19;
          break;
        default:
      }
    }
    DateTime dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    if (selectDay != null) {
      switch (selectDay.toLowerCase().trim()) {
        case 'ontem':
          dateTime = dateTime.subtract(Duration(days: 1));
          break;
        case 'anteontem':
          dateTime = dateTime.subtract(Duration(days: 2));
          break;
      }
    }

    return dateTime;
  }
}
