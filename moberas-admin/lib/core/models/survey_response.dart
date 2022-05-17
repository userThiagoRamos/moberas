import 'package:json_annotation/json_annotation.dart';

import 'converters/time_day_converter.dart';

part 'survey_response.g.dart';

@JsonSerializable()
@TimeOfDayConverter()
class SurveyResponse {
  final int selectedValue;
  final DateTime dateTime;

  SurveyResponse({this.selectedValue, this.dateTime});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}
