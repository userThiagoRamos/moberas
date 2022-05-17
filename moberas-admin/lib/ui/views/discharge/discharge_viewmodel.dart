import 'package:flutter/material.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DischargeViewModel extends BaseViewModel {
  TextEditingController textController = TextEditingController();
  final SnackbarService _snackBarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> sendHelpMsg(String msg) async {
    await UserProfileData().registerUserQuestion(msg);
    _snackBarService.showSnackbar(
        message:
            'Sua dúvida foi registrada e em breve entraremos em contato com você.');
    textController.clear();
  }

  Future<void> goToUserExperienceSurvey() async =>
      await _navigationService.clearStackAndShow(Routes.validationSurveyView);
}
