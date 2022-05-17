import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  static String CollectionPath = 'users';
  final String id;
  final String displayName;
  final GeoPoint loginLocation;
  final bool showIntroVideo;
  final int score;
  final String cpf;
  final bool admin;

  UserProfile(
      {this.id,
      this.displayName,
      this.loginLocation,
      this.showIntroVideo,
      this.score,
      this.cpf,
      this.admin});

  factory UserProfile.fromData(Map<String, dynamic> data) {
    if (data == null) return null;
    return UserProfile(
        id: data['uid'] ?? '',
        displayName: data['displayName'] ?? '',
        loginLocation: data['loginLocation'] as GeoPoint ?? GeoPoint(1.0, 1.0),
        showIntroVideo: data['showIntroVideo'] ?? false,
        score: data['score'] ?? 0,
        cpf: data['cpf'] ?? '',
        admin: data['admin'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'displayName': displayName,
      'loginLocation': loginLocation,
    };
  }
}
