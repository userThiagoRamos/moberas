import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey.dart';
import 'package:mobEras/core/models/theme_cfg.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/core/models/survey_status_model.dart';

enum Emojies { happy, congrats, walk, nice }

class Global {
  static final Map models = {
    UserProfile: (data, documentID) => UserProfile.fromData(data),
    Activity: (data, documentID) => Activity.fromData(data, documentID),
    ThemeCfg: (data, documentID) => ThemeCfg.fromJson(data),
    SurveyStatusModel: (data, documentID) => SurveyStatusModel.fromJson(data),
    Milestone: (data, documentID) => Milestone.fromData(data, documentID),
    Survey: (data, documentID) => Survey.fromJson(data)
  };

  // Firestore References for Writes
  static final UserProfileData userProfileRef = UserProfileData();

  static const eightHoursSchedule = [22, 6];
  static const fourHoursSchedule = [10, 14, 18];
}
