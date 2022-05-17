import 'package:mobEras/core/models/base/i_survey_entity.dart';

class Activity implements ISurveyEntity {
  static final String CollectionPath = 'activities';

  final String id;

  final String name;

  final String question;

  final String scale;

  final int order;

  Activity({this.id, this.name, this.question, this.scale, this.order});

  factory Activity.fromData(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    return Activity(
        id: documentId ?? '',
        name: data['name'] ?? '',
        question: data['question'] ?? '',
        order: data['order'] ?? 0,
        scale: data['scale'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'question': question};
  }
}
