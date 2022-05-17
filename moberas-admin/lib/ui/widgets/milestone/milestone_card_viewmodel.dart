import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/audio/audio_service.dart';
import 'package:mobEras/core/services/milestone/milestone_service_interface.dart';
import 'package:mobEras/ui/widgets/dialogs/milestone/mlt_confirm_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:pedantic/pedantic.dart';

class MilestoneCardViewModel extends BaseViewModel {
  final IMilestoneService _milestoneService = locator<IMilestoneService>();
  final DialogService _dialogService = locator<DialogService>();
  final AudioService _audioService = locator<AudioService>();

  String localFilePath;
  final AudioService audioService = locator<AudioService>();

  Future<void> registerResponse({@required Milestone milestone, @required SurveyResponse surveyResponse}) async {
    unawaited(_audioService.close());
    await runBusyFuture(_milestoneService.registerMilestoneCompletion(milestone: milestone, surveyResponse: surveyResponse));
    notifyListeners();
  }

  Future<DialogResponse> confirmSelection(Milestone mlt) async {
    return await _dialogService.showCustomDialog(
      variant: DialogType.base,
      customData: {'mlt': mlt},
    );
  }
}
