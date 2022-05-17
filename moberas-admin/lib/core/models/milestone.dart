import 'package:mobEras/core/models/base/i_survey_entity.dart';

class Milestone implements ISurveyEntity {
  final String id;
  final String name;
  final String description;

  Milestone({this.id, this.name, this.description});

  factory Milestone.fromData(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    return Milestone(
        id: documentId ?? '',
        name: data['name'] ?? '',
        description: data['description'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
