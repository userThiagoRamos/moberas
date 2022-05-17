import 'package:logging/logging.dart';

class Activity {
  static const String CollectionPath = 'activities';

  final String id;
  final String name;
  final int order;
  final String question;
  final String scale;

  Activity({this.name, this.order, this.question, this.scale, this.id});

  factory Activity.fromJson(Map<String, dynamic> data, String uid) {
    if (data == null) return null;
    try {
      return Activity(
        id: uid,
        name: data['name'] ?? '',
        order: data['order'] ?? 0,
        question: data['question'] ?? '',
        scale: data['scale'] ?? '',
      );
    } catch (e) {
      Logger('Activity').severe('Erro fromData', e);
      return null;
    }
  }
}
