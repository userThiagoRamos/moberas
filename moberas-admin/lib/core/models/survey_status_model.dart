import 'package:json_annotation/json_annotation.dart';

part 'survey_status_model.g.dart';

@JsonSerializable()
class SurveyStatusModel {
  bool dynamicOnDisplay;
  bool milestoneOnDisplay;

  SurveyStatusModel({this.dynamicOnDisplay,this.milestoneOnDisplay});

   factory SurveyStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyStatusModelToJson(this);

  factory SurveyStatusModel.defaultSurveyManager() => SurveyStatusModel(
   dynamicOnDisplay:false,milestoneOnDisplay: true);
}