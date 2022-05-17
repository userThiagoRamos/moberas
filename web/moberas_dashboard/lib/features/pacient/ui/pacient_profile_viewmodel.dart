import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/database/globals.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/position.dart';
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
  MapController mapController = MapController();

  List<MilestoneResponse> get fetchedMilestone => dataMap[dataMilestone];
  List<ActivityResponse> get fetchedDynamic => dataMap[dataDynamic];
  final ScrollController controller = ScrollController();

  bool get fetchingMilestone => busy(dataMilestone);
  bool get fetchingDynamic => busy(dataMilestone);

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

  void fetchPacient(UserProfile userProfile) {
    selectedPacient = userProfile;
  }

  Future<List<Marker>> fetchMapaData() async {
    List<PositionModel> positionList =
        await _pacientService.fecthPositions(selectedPacient.uid);
    return positionList
        .where((element) =>
            positionList.indexOf(element) == 0 ||
            positionList.indexOf(element) == positionList.length - 1)
        .map(
          (p) => Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(p.position.latitude, p.position.longitude),
            builder: (ctx) => Container(
              child: IconButton(
                icon: Icon(Icons.adjust),
                color: positionList.indexOf(p) == 0
                    ? Colors.green
                    : positionList.indexOf(p) == positionList.length - 1
                        ? Colors.red
                        : Colors.black,
                tooltip: DateFormat('dd/MM/y hh:mm:ss:mmm').format(
                  p.dateTime.toDate(),
                ),
                onPressed: () => null,
              ),
            ),
          ),
        )
        .toList();
  }

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

  Future<int> getDistance() async =>
      await _pacientService.calculateDistance(selectedPacient.uid);

  Future<void> goToSurveyAppView() async {
    _navigationService.navigateTo(Routes.surveyAppView,
        arguments: SurveyAppViewArguments(profile: selectedPacient));
  }

  String formatDate(Timestamp date) {
    return date != null
        ? Global.SDF.format(date.toDate())
        : 'Data não informada';
  }
}
