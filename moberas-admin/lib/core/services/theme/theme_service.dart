import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/theme_cfg.dart';
import 'package:mobEras/core/services/theme/theme_service_interface.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: IThemeService)
class ThemeService implements IThemeService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<ThemeCfg> getTheme() {
    return _firebaseAuth.onAuthStateChanged.switchMap((user) {
      if (user != null) {
        return Document<ThemeCfg>(
                path:
                    'users/${user.uid}/private_profile/${user.uid}/preferences/theme')
            .streamData();
      } else {
        return Document<ThemeCfg>(path: 'preferences/textTheme').streamData();
      }
    });
  }

  @override
  Stream<ThemeCfg> get themeCfg$ => getTheme();
}
