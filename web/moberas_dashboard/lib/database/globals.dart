import 'package:intl/intl.dart';
import 'package:moberas_dashboard/features/activities/models/activity.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/position.dart';
import 'package:moberas_dashboard/features/pacient/models/survey_app_model.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';

class Global {
  static final DateFormat SDF = DateFormat('dd/MM/yyyy HH:mm');
  static final Map models = {
    SurveyAppModel:(data,documentID) => SurveyAppModel.fromMap(data),
    PositionModel: (data, documentID) => PositionModel.fromData(data),
    UserProfile: (data, documentID) => UserProfile.fromData(data),
    ThemeCfg: (data, documentID) => ThemeCfg.fromJson(data),
    Activity: (data, documentID) => Activity.fromJson(data, documentID),
    ActivityResponse: (data, documentID) =>
        ActivityResponse.fromJson(data, documentID),
    MilestoneResponse: (data, documentID) =>
        MilestoneResponse.fromJson(data, documentID),
  };
}
