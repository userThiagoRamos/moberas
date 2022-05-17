import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';

abstract class IPacientThemeInterface {
  Future<void> updateTheme(ThemeCfg themeCfg, UserProfile pacient);
}