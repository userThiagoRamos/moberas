import 'package:logging/logging.dart';
import 'package:moberas_dashboard/features/activities/services/activities_services.dart';
import 'package:moberas_dashboard/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';

class ActivitiesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ActivitiesServices _service = locator<ActivitiesServices>();
  final _log = Logger('ActivitiesViewModel');

  dynamic onFormSubmit(Map map) async {
    try {
      await _service.submitActivity(map);
      DialogService().showDialog(
        title: 'Sucesso',
        description: 'Atividade adicionada com sucesso',
      );
    } catch (e) {
      _log.shout(e);
    }
  }

  void profile() {
    _navigationService.navigateTo(Routes.pacientProfileView);
  }
}
