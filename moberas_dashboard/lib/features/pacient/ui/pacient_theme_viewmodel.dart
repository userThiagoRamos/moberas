import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/commons/extensions/color_x.dart';
import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_theme_service_interface.dart';
import 'package:moberas_dashboard/locator.dart';
import 'package:moberas_dashboard/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PacientThemeViewModel extends FutureViewModel<void> {
  PacientThemeViewModel(UserProfile profile) {
    selectedPacient = profile;
  }

  var cpfController = TextEditingController();
  var nameController = TextEditingController();
  List<UserProfile> pacients;
  UserProfile selectedPacient;

  final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();
  final _log = Logger('PacientProfileViewModel');
  ThemeCfg _model;
  final NavigationService _navigationService = locator<NavigationService>();
  final IPacientService _pacientService = locator<IPacientService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final IPacientThemeInterface _themeService =
      locator<IPacientThemeInterface>();

  @override
  Future<void> futureToRun() => _fetchTheme();

  Future<void> _fetchTheme() async {
    if (selectedPacient != null) {
      _model = await UserThemeData().fetchTheme(selectedPacient.uid);
    } else {
      _model = ThemeCfg.defaultTheme();
      _log.fine('nao achou profile');
    }
    notifyListeners();
  }

  Future<List<UserProfile>> findPacientByNameOrCpf() async {
    pacients = await runBusyFuture(_pacientService.findByNameOrCpf(
        nameController.text, cpfController.text));
    return pacients;
  }

  void returnToView() {
    _navigationService.navigateTo(Routes.pacientView);
  }

  Future<void> fetchPacient(String pacientUID) async =>
      selectedPacient = await _pacientService.fetchByUID(uid: pacientUID);

  GlobalKey<FormState> get formKey => _fbKey;

  ThemeCfg get model => _model;

  //COLORS - ini

  get textColor => HexColor.fromHex(_model.textColor);

  set textColor(String pc) {
    _model.textColor = pc;
  }

  get accentColor => HexColor.fromHex(_model.accentColor);

  set accentColor(String pc) {
    _model.accentColor = pc;
  }

  get primaryColor => HexColor.fromHex(_model.primaryColor);

  set primaryColor(String pc) {
    _model.primaryColor = pc;
  }

  get cardColor => HexColor.fromHex(_model.cardColor);

  set cardColor(String color) {
    _model.cardColor = color;
  }

  textColorChanged(Color color) {
    _model..textColor = color.toHex();
    registerColorChange();
  }

  cardColorChanged(Color color) {
    _model..cardColor = color.toHex();
    registerColorChange();
  }

  primaryColorChanged(Color color) {
    _model..primaryColor = color.toHex();
    registerColorChange();
  }

  accentColorChanged(Color color) {
    _model..accentColor = color.toHex();
    registerColorChange();
  }

  void registerColorChange() {
    _navigationService.popRepeated(1);
    notifyListeners();
  }

  //COLORS -end

  void registerSizeChange() {
    notifyListeners();
  }

  Future<void> updateTheme() async {
    final form = _fbKey.currentState;
    form.save();
    _themeService.updateTheme(_model, selectedPacient);
    _snackbarService.showSnackbar(
        message: 'Tema atualizado com sucesso',
        title: 'moberas',
        duration: Duration(seconds: 2));
  }

  ///headline1
  get headline1TextSize => _model.headline1Size;

  set headline1TextSize(double size) {
    _model.headline1Size = size;
  }

  get headline1TextColor => HexColor.fromHex(_model.surveyItemTextColor);

  set headline1TextColor(String color) {
    _model.surveyItemTextColor = color;
  }

  headline1TextSizeChanged(double size) {
    _model..headline1Size = size;
    registerSizeChange();
  }

  headline1ColorChanged(Color color) {
    _model..surveyItemTextColor = color.toHex();
    registerColorChange();
  }

  ///headline2
  get headline2TextSize => _model.headline2Size;

  set headline2TextSize(double size) {
    _model.headline2Size = size;
  }

  get headline2TextColor => HexColor.fromHex(_model.msgPanelTextColor);

  set headline2TextColor(String color) {
    _model.msgPanelTextColor = color;
  }

  headline2TextSizeChanged(double size) {
    _model..headline2Size = size;
    registerSizeChange();
  }

  headline2ColorChanged(Color color) {
    _model..msgPanelTextColor = color.toHex();
    registerColorChange();
  }

  ///headline3
  get headline3TextSize => _model.headline3Size;

  set headline3TextSize(double size) {
    _model.headline2Size = size;
  }

  get headline3TextColor => HexColor.fromHex(_model.questionPanelTextColor);

  set headline3TextColor(String color) {
    _model.questionPanelTextColor = color;
  }

  headline3TextSizeChanged(double size) {
    _model..headline3Size = size;
    registerSizeChange();
  }

  headline3ColorChanged(Color color) {
    _model..questionPanelTextColor = color.toHex();
    registerColorChange();
  }

  ///headline4
  get headline4TextSize => _model.headline4Size;

  set headline4TextSize(double size) {
    _model.headline4Size = size;
  }

  get headline4TextColor => HexColor.fromHex(_model.dynamicIntroTextColor);

  set headline4TextColor(String color) {
    _model.dynamicIntroTextColor = color;
  }

  headline4TextSizeChanged(double size) {
    _model..headline4Size = size;
    registerSizeChange();
  }

  headline4ColorChanged(Color color) {
    _model..dynamicIntroTextColor = color.toHex();
    registerColorChange();
  }

  ///headline5
  get headline5TextSize => _model.headline5;

  set headline5TextSize(double size) {
    _model.headline5 = size;
  }

  get headline5TextColor => HexColor.fromHex(_model.textColor);

  set headline5TextColor(String color) {
    _model.textColor = color;
  }

  headline5TextSizeChanged(double size) {
    _model..headline5 = size;
    registerSizeChange();
  }

  headline5ColorChanged(Color color) {
    _model..textColor = color.toHex();
    registerColorChange();
  }

  ///headline6
  get headline6TextSize => _model.headline6Size;

  set headline6TextSize(double size) {
    _model.headline6Size = size;
  }

  get headline6TextColor => HexColor.fromHex(_model.textColor);

  set headline6TextColor(String color) {
    _model.textColor = color;
  }

  headline6TextSizeChanged(double size) {
    _model..headline6Size = size;
    registerSizeChange();
  }

  headline6ColorChanged(Color color) {
    _model..textColor = color.toHex();
    registerColorChange();
  }

  ///button
  get buttonTexSize => _model.buttonSize;

  set buttonTextSize(double size) {
    _model.buttonSize = size;
  }

  get buttonTextColor => HexColor.fromHex(_model.buttonTextColor);

  set buttonTextColor(String color) {
    _model.buttonTextColor = color;
  }

  get buttonColor => HexColor.fromHex(_model.buttonColor);

  set buttonColor(String color) {
    _model.buttonColor = color;
  }

  buttonTextSizeChanged(double size) {
    _model..buttonSize = size;
    registerSizeChange();
  }

  buttonColorChanged(Color color) {
    _model..buttonColor = color.toHex();
    registerColorChange();
  }

  buttonTextColorChanged(Color color) {
    _model..buttonTextColor = color.toHex();
    registerColorChange();
  }
}
