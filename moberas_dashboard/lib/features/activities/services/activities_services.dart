import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:moberas_dashboard/features/activities/models/activity.dart';

@singleton
class ActivitiesServices {
  Future<void> submitActivity(Map map) {
    final Firestore _db = Firestore.instance;
    final doc = _db.collection(Activity.CollectionPath).document();

    return doc.setData(map);
  }
}
