import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class UserProfile {
  static const String CollectionPath = 'users';

  final String displayName;
  final String email;
  final String username;

  final GeoPoint loginLocation;
  final bool online;
  final int score;
  final String uid;
  final String cpf;
  final Map<String, int> steps;
  final String status;

  UserProfile(
      {this.displayName,
      this.email,
      this.username,
      this.loginLocation,
      this.online,
      this.score,
      this.uid,
      this.cpf,
      this.steps,
      this.status});

  int get totalSteps =>
      this.steps.values.reduce((sum, element) => sum + element);

  factory UserProfile.fromData(Map<String, dynamic> data) {
    var up = null;

    try {
      up = UserProfile(
          displayName: data['displayName'] ?? 'sem nome',
          email: data['email'] ?? 'na',
          username: data['username'] ?? 'na',
          loginLocation: data['loginLocation'] ?? GeoPoint(12.0000, 11.000),
          online: data['online'] ?? false,
          score: data['score'] ?? 0,
          cpf: data['cpf'] ?? '111',
          steps: Map<String, int>.from(data['steps'] ?? {'10/10/2020:0'}),
          uid: data['uid'],
          status: data['status'] ?? 'inativo');
      return up;
    } catch (e) {
      Logger('UserProfile').severe('Erro fromData', e);
    } finally {
      return up;
    }
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'displayName': displayName ?? displayName,
      'email': email ?? email,
      'username': username ?? username,
    };
  }

  @override
  String toString() {
    return 'Name: ' +
        displayName +
        '\n' +
        'Email: ' +
        email +
        '\n' +
        'Username: ' +
        username +
        '\n';
  }
}
