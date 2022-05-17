import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/milestone/milestone_service_interface.dart';
import 'package:mobEras/core/services/survey/survey_service_interface.dart';
import 'package:mobEras/ui/widgets/appbar/service/appbar_service_interface.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBarViewModel extends StreamViewModel<UserProfile> {
  final IAppBarService _userStatusService = locator<IAppBarService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navService = locator<NavigationService>();
  final IMilestoneService  _milestoneService = locator<IMilestoneService>();
  final ISurveyService _surveyService = locator<ISurveyService>();
  final Firestore _firestore = Firestore.instance;

  Map<String, String> appRoutes = {
    'Tela de login': Routes.loginView,
    'Tela de instruções': Routes.textIntroView,
    'Tela de TCLE': Routes.tcleView,
    'Video de introdução': Routes.mobErasVideoIntroView,
    'Tela de alta do paciente': Routes.pacientFormView,
    'Tela texto de orientações': Routes.dischargeView,
    'Tela questionário validação': Routes.validationSurveyView
  };

  TextEditingController superUserCpfController = TextEditingController();

  @override
  Stream<UserProfile> get stream => _userStatusService.userProfile$;

  TextEditingController helpMsgController = TextEditingController();

  Future<void> sendHelpMsg(String msg) async {
    await UserProfileData().registerUserQuestion(msg);
    helpMsgController.clear();
    _navService.popRepeated(1);
  }

  Future<void> resetSurvey() async {
    await _milestoneService.resetMilestoneSurvey();
  }

  Future<void> showDynamicSurvey() async {
    await _surveyService.triggerDynamicSurvey('4 horas');
  }

  Future<void> navigate(int index) async {
    var route = appRoutes.values.toList()[index];
    await _navService.navigateTo(route);
  }

  Future<void> grantAccess(bool grantAccess) async {
    var querySnapshot = await _firestore
        .collection('users')
        .where('cpf', isEqualTo: superUserCpfController.text.trim())
        .limit(1)
        .getDocuments();
    if (querySnapshot.documents.isEmpty) {
      _snackbarService.showSnackbar(
          message:
              'Usuário não localizado. Certifique-se que o usuário já realizou o login.');
    } else {
      await querySnapshot.documents[0].reference
          .setData({'admin': grantAccess}, merge: true);
      _snackbarService.showSnackbar(
          message:
              'Acesso ${grantAccess ? 'concedido' : 'removido'} para ${querySnapshot.documents[0].data['displayName']}');
    }
  }
}
