import 'package:mobEras/core/models/user_profile.dart';

abstract class AuthenticationService {
  Future<dynamic> login(String username, String birthday, String cpf);

  Future<void> signOut();

  Future<bool> get isUserLoggedIn;

  Future<UserProfile> get currentUser;
}
