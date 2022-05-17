import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';
import 'package:stacked/stacked.dart';

import '../../../../locator.dart';

class MilestoneReportViewModel
    extends StreamViewModel<List<MilestoneResponse>> {
  MilestoneReportViewModel(UserProfile user) {
    selectedPacient = user;
  }

  UserProfile selectedPacient;

  final IPacientService _pacientService = locator<IPacientService>();

  @override
  Stream<List<MilestoneResponse>> get stream => streamMilestone();

  bool sortAscending = true;

  Stream<List<MilestoneResponse>> streamMilestone() {
    return _pacientService.streamMilestoneResponseList(selectedPacient.uid);
  }

  void onSortColum(int columnIndex, bool ascending) {
    sortAscending = !sortAscending;
    if (columnIndex == 1) {
      if (ascending) {
        data.sort((a, b) => a.responseDate.compareTo(b.responseDate));
      } else {
        data.sort((a, b) => b.responseDate.compareTo(a.responseDate));
      }
    }
    notifyListeners();
  }
}
