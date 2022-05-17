import 'package:cloud_firestore/cloud_firestore.dart';

class PositionModel {
  final Timestamp dateTime;
  final GeoPoint position;

  PositionModel({this.dateTime, this.position});

  factory PositionModel.fromData(Map<String, dynamic> data) => PositionModel(dateTime: data['date'],position: data['position']);
}
