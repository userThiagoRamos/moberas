import 'package:moberas_dashboard/commons/date_time_converter.dart';
import 'package:moberas_dashboard/database/globals.dart';

@DateTimeConverter()
class MilestoneResponse {
  final String milestone;
  final DateTime responseDate;

  MilestoneResponse({this.milestone, this.responseDate});

  String get formatedDate => Global.SDF.format(this.responseDate);

  factory MilestoneResponse.fromJson(Map<String, dynamic> data, String id) {
    if (data == null) return null;
    try {
      return MilestoneResponse(
        milestone: data['milestone'] ?? '',
        responseDate: data['response_date'].toDate() ?? DateTime.now(),
      );
    } catch (e) {
      return MilestoneResponse(
          milestone: 'Sem nome', responseDate: DateTime.now());
    }
  }
}
