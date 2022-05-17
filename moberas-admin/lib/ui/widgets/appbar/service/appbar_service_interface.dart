import 'package:mobEras/core/models/user_profile.dart';

abstract class IAppBarService {
  Stream<UserProfile> get userProfile$;
}
