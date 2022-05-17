import 'package:flutter/material.dart';
import 'package:mobEras/core/models/theme_cfg.dart';
import 'package:mobEras/ui/shared/themes.dart';

Color pushContainerColor = Color.fromARGB(255, 61, 63, 69);
Color milestoneTileColor = Color.fromARGB(255, 18, 18, 19);

void setAuxColors(ThemeCfg themeCfg) {
  pushContainerColor = HexColor.fromHex(themeCfg.pushContainerColor);
  milestoneTileColor = HexColor.fromHex(themeCfg.accentColor);
}
