import 'package:mobEras/core/models/theme_cfg.dart';

abstract class IThemeService {
  Stream<ThemeCfg> get themeCfg$;
}
