import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  

  Future handleStartUpLogic() async {
    try {
      var isLogged = await _authenticationService.isUserLoggedIn;

      if (isLogged) {
        final currentUser = await _authenticationService.currentUser;

        unawaited(_navigationService.navigateTo(currentUser.showIntroVideo
            ? Routes.tcleView
            : Routes.milestoneSurveyView));
      } else {
        unawaited(_navigationService.pushNamedAndRemoveUntil(Routes.loginView));
      }
    } catch (e) {
      Logger.e('startup $e', e: e);
    }
  }
}
