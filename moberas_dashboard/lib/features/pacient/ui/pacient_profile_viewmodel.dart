import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';
import 'package:moberas_dashboard/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';

class PacientProfileViewModel extends MultipleFutureViewModel {
  static final String dataMilestone = 'dm';
  static final String dataDynamic = 'dd';

  List<MilestoneResponse> get fetchedMilestone => dataMap[dataMilestone];
  List<ActivityResponse> get fetchedDynamic => dataMap[dataDynamic];

  bool get fetchingMilestone => busy(dataMilestone);
  bool get fetchingDynamic => busy(dataMilestone);

  PacientProfileViewModel(UserProfile profile) {
    selectedPacient = profile;
  }

  UserProfile selectedPacient;
  bool milestoneSortAscending = true;
  bool dynamicSortAscending = true;

  final _log = Logger('PacientProfileViewModel');

  final NavigationService _navigationService = locator<NavigationService>();
  final IPacientService _pacientService = locator<IPacientService>();
  List<MilestoneResponse> milestones = [];

  void returnToView() {
    _navigationService.navigateTo(Routes.pacientView);
  }

  Future<void> fetchPacient(String pacientUID) async =>
      selectedPacient = await _pacientService.fetchByUID(uid: pacientUID);

  Future<void> goToUserTheme() async {
    _navigationService.navigateTo(Routes.pacientThemeView,
        arguments: PacientThemeViewArguments(profile: selectedPacient));
  }

  Future<List<MilestoneResponse>> fetchMilestones() async {
    return await _pacientService
        .fetchMilestoneResponseList(selectedPacient.uid);
  }

  Future<List<ActivityResponse>> fetchDynamic() async {
    return await _pacientService.fetchDynamicResponseList(selectedPacient.uid);
  }

  void onSortColum(int columnIndex, bool ascending) {
    milestoneSortAscending = !milestoneSortAscending;
    if (columnIndex == 1) {
      if (ascending) {
        fetchedMilestone
            .sort((a, b) => a.responseDate.compareTo(b.responseDate));
      } else {
        fetchedMilestone
            .sort((a, b) => b.responseDate.compareTo(a.responseDate));
      }
    }
    notifyListeners();
  }

  @override
  Map<String, Future Function()> get futuresMap =>
      {dataMilestone: fetchMilestones, dataDynamic: fetchDynamic};

  Future<void> goToDynamicReport() async {
    _navigationService.navigateTo(Routes.dynamicReportView,
        arguments: DynamicReportViewArguments(profile: selectedPacient));
  }

  Future<void> goToMilestoneReport() async {
    _navigationService.navigateTo(Routes.milestoneReportView,
        arguments: MilestoneReportViewArguments(profile: selectedPacient));
  }

  Future<void> startDynamicSurvey() async {
    await _pacientService.sendMsg(selectedPacient.uid, 'dynamicOnDisplay');
  }
}
