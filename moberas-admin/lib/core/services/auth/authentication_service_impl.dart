import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:mobEras/core/services/location/location_service.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:mobEras/core/services/schedule/survey_schedule_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked_services/stacked_services.dart';

@Singleton(as: AuthenticationService)
class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final LocationService _locationService;
  final NavigationService _navService;
  final AnalyticsService _analyticsService;
  final SurveyScheduleService scheduleService;
  final ProfileService _profileService;
  AuthenticationServiceImpl(
      this.scheduleService, this._analyticsService, this._navService, this._locationService, this._profileService);

  Stream<UserProfile> profile$;

  final Random _rnd = Random();
  String getRandomString(int length, String base) => String.fromCharCodes(
      Iterable.generate(length, (_) => base.codeUnitAt(_rnd.nextInt(base.length))));

  @override
  Future<dynamic> login(String username, String birthday, String cpf) async {
    var email = '${cpf}@moberas.com';
    final user = await isUserRegistered(cpf);
    if (user != null) {
      initUserServices(user.user.uid, user.user.email);
      return true;
    } else {
      try {
        var password = cpf;
        var authResult =
            await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        if (authResult != null && authResult.user != null) {
          await UserProfileData().upsert({
            'displayName': username,
            'birthdayDate': birthday,
            'cpf': cpf,
            'status': 'active',
            'online': true,
          });
          initUserServices(authResult.user.uid, authResult.user.email);
          return true;
        } else {
          return 'Usuário ou senha inválidos';
        }
      } catch (e) {
        Logger.e('login $e', e: e);
        return 'Usuário ou senha inválidos';
      }
    }
  }

  void initUserServices(String uid, String email) {
    unawaited(_analyticsService.logLogin());
    unawaited(_analyticsService.setUserProperties(userId: uid, email: email));
    _locationService.start();
    unawaited(_locationService.registerLocation());
    unawaited(scheduleService.setup());
    unawaited(_profileService.setUserOnlineStatus(true));
  }

  Future<dynamic> isUserRegistered(String cpf) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: '${cpf}@moberas.com', password: cpf)
        ..user;
    } catch (e) {
      Logger.e('checkUser $e', e: e);
      return null;
    }
  }

  @override
  Future<UserProfile> get currentUser async => await UserProfileData().getDocument();

  @override
  Future<bool> get isUserLoggedIn async {
    var currentUser = await _firebaseAuth.currentUser();
    return currentUser != null && currentUser.isAnonymous == false;
  }

  @override
  Future<void> signOut() async {
    _locationService.stop();
    unawaited(_profileService.setUserOnlineStatus(false));
    await _firebaseAuth.signOut();
    await _navService.clearStackAndShow(Routes.loginView);
  }
}
