import 'package:moberas_dashboard/database/globals.dart';

class ActivityResponse {
  final String id;
  final String activity;
  final DateTime responseDate;
  final String responseUserUid;
  final int responseValue;

  ActivityResponse(
      {this.id,
      this.activity,
      this.responseDate,
      this.responseUserUid,
      this.responseValue});

  String get formatedDate => Global.SDF.format(this.responseDate);

  factory ActivityResponse.fromJson(Map<String, dynamic> data, String id) {
    if (data == null) return null;
    try {
      return ActivityResponse(
          id: id,
          activity: data['activity'] ?? 'no activity',
          responseDate: data['response_date'].toDate() ?? DateTime.now(),
          responseUserUid: data['response_user_uid'] ?? 'no user',
          responseValue: data['response_value'] ?? 0);
    } catch (e) {
      return ActivityResponse();
    }
  }
}
