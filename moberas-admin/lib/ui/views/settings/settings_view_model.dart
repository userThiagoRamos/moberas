import 'package:mobEras/core/constants/local_keys.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthenticationService>();
  final _snackBarService = locator<SnackbarService>();

  bool _notificationsEnabled = false;
  bool get notificationsEnabled => _notificationsEnabled;

  void openAppSettings() {
    Logger.d('User has opened app settings');
  }

  Future<void> signOut() async {
    final dialogResponse = await _dialogService.showDialog(
        title: LocalKeys.settings_view_sign_out,
        description: LocalKeys.settings_view_sign_out_desc,
        buttonTitle: LocalKeys.button_confirm);

    if (dialogResponse.confirmed) {
      Logger.d('User has signed out');
      await _authService.signOut();
      await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }

  void toggleNotificationsEnabled() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  // Snack bar Sample usage
  Future<void> showSnackbar() async {
    await _snackBarService.showSnackbar(message: LocalKeys.snackbar_message);
  }
}
