import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';

import 'authentication_service.dart';

@Singleton(as: AuthenticationService)
class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _log = Logger('AuthenticationService');

  @override
  Future<bool> get isUserLoggedIn async {
    var currentUser = await _firebaseAuth.currentUser();
    return currentUser != null && currentUser.isAnonymous == false;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserProfile> get currentUser async =>
      await UserProfileData().getDocument();

  @override
  Future<bool> login(String email, password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      //validar o UID junto ao bando de dados
      return authResult.user != null;
    } catch (e) {
      _log.severe(e);
      return false;
    }
  }

  @override
  Future<void> changePassword(String email) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
}
