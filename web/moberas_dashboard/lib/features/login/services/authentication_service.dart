import 'package:moberas_dashboard/features/login/models/user_profile.dart';

abstract class AuthenticationService {
  Future<void> signOut();
  Future<bool> get isUserLoggedIn;
  Future<UserProfile> get currentUser;
  Future<bool> login(String email, password);
  Future<void> changePassword(String email);
}
