import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/mixins/validators.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  String month = 'Janeiro';

  void setMonth(String newMonth) {
    month = newMonth;
    notifyListeners();
  }

  Future<void> login(String name, String birthday, String cpf) async {
    if (cpf == null || cpf.isEmpty) {
      await _dialogService.showConfirmationDialog(
          title: 'moberas', description: 'Informe o cpf');
    }
    if (name == null || name.isEmpty) {
      await _dialogService.showConfirmationDialog(
          title: 'moberas', description: 'Informe o nome');
    } else {
      var result = await runBusyFuture(
          _authenticationService.login(name.trim(), birthday, cpf));
      await runBusyFuture(_checkSignInResult(result));
    }
  }

  Future _checkSignInResult(result) async {
    if (result is bool) {
      if (result) {
        await _navigationService.clearStackAndShow(Routes.startupView);
      } else {
        await _dialogService.showDialog(
          title: 'Erro na autenticação',
          description: 'Senha ou usuário inválidos.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Erro na autenticação',
        description: 'Senha ou usuário inválidos.',
      );
    }
  }

  setCpf(value) {}
}
