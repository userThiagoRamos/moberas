import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';

@JsonSerializable()
class Survey {
  static var PATH = 'users/##/private_profile/##/survey/##';

  final bool dynamicOnDisplay;
  final bool milestoneOnDisplay;
  final DateTime lastView;

  Survey(this.dynamicOnDisplay, this.milestoneOnDisplay, this.lastView);

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, String> toJson() => _$SurveyToJson(this);
}
