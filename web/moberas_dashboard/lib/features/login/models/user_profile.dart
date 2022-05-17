import 'package:cloud_firestore/cloud_firestore.dart';

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
  final Timestamp dataAlta;
  final Timestamp datadacirurgia;
  final Timestamp datadeinternacao;

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
      this.status,
      this.dataAlta,
      this.datadacirurgia,
      this.datadeinternacao});

  factory UserProfile.fromData(Map<String, dynamic> data) {
    if (data != null && data.isNotEmpty) {
      try {
        return UserProfile(
            displayName: data['displayName'] ?? 'sem nome',
            email: data['email'] ?? 'na',
            username: data['username'] ?? 'na',
            loginLocation: data['loginLocation'] ?? GeoPoint(12.0000, 11.000),
            online: data['online'] ?? false,
            score: data['score'] ?? 0,
            cpf: data['cpf'] ?? '111',
            uid: data['uid'],
            dataAlta: data['dataAlta'],
            datadacirurgia: data['datadacirurgia'],
            datadeinternacao: data['datadeinternação'],
            status: data['status'] ?? 'inativo');
      } catch (e) {
        print('error ${e.toString()}');
        return null;
      }
    } else {
      return null;
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
