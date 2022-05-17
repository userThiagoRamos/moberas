import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String key_milestone = 'key_mlt';
const String key_push_msg = 'key_push_msg';

class MilestoneSurveyViewModel extends StreamViewModel {
  final _navService = locator<NavigationService>();
  final ISurveyService _sourveyService = locator<ISurveyService>();
  final DialogService _dialogService = locator<DialogService>();

  @override
  Stream get stream => _sourveyService.milestoneList$;

  String get titleText => 'Clique na caixa que indica a primeira vez que...';

  @override
  void onData(data) {
    super.onData(data);
    if (data == null || data.isEmpty) {
      setDisplayOff();
      _navService.navigateTo(Routes.homeView);
    }
  }

  void setDisplayOff() async {
    await _sourveyService.dismissMilestoneSurvey();
  }

  Future<void> initiDischargeProcedureFlow() async {
    DialogResponse dialogResponse = await _dialogService.showConfirmationDialog(
        dialogPlatform: DialogPlatform.Cupertino,
        title: 'mobEras',
        description: 'Você confirma que recebeu alta?',
        confirmationTitle: 'Sim',
        cancelTitle: 'Não');
    dialogResponse.confirmed ? await registerDischargeDate() : null;
  }

  Future<void> registerDischargeDate() async {
    await UserProfileData().upsert({'dataAlta': DateTime.now()});
    await _navService.clearStackAndShow(Routes.pacientFormView);
  }
}
