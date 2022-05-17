import 'package:flutter/material.dart';
import 'package:moberas_dashboard/commons/validators.dart';
import 'package:moberas_dashboard/features/login/services/authentication_service.dart';
import 'package:moberas_dashboard/router/router.gr.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future checkSignInResult(result) async {}

  Future<void> login(
      {@required String email, @required String password}) async {
    setBusy(true);
    var success = await _authenticationService.login(email, password);
    if (success) {
      _navigationService.clearStackAndShow(Routes.pacientView);
    } else {
      _snackbarService.showSnackbar(
          message: 'Usuário ou senha inválidos', title: 'Login');
    }
    setBusy(false);
  }
}
