import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobEras/core/models/theme_cfg.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

final _lightThemeData = ThemeData.light();
final _darkThemeData = ThemeData.dark();

final primaryMaterialTheme = (ThemeCfg themeCfg) => _lightThemeData.copyWith(
      buttonTheme: ButtonThemeData().copyWith(
        height: themeCfg.buttonSize ?? 40.0,
        colorScheme: ColorScheme.light().copyWith(
            primary: themeCfg.buttonColor != null
                ? HexColor.fromHex(themeCfg.buttonColor)
                : Colors.orange),
      ),
      cardColor: themeCfg.cardColor != null
          ? HexColor.fromHex(themeCfg.cardColor)
          : Colors.blue,
      primaryColor: themeCfg.primaryColor != null
          ? HexColor.fromHex(themeCfg.primaryColor)
          : Colors.blue,
      accentColor: themeCfg.accentColor != null
          ? HexColor.fromHex(themeCfg.accentColor)
          : Colors.blueAccent,
      buttonColor: themeCfg.buttonColor != null
          ? HexColor.fromHex(themeCfg.buttonColor)
          : Colors.green,
      textTheme: GoogleFonts.robotoTextTheme()
          .copyWith(
            bodyText1: TextStyle(
                fontSize: themeCfg?.bodyText1Size ?? 16.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            bodyText2: TextStyle(
                fontSize: themeCfg?.bodyText2Size ?? 14.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline1: TextStyle(
                fontSize: themeCfg?.headline1Size ?? 50.0,
                color: themeCfg.surveyItemTextColor != null
                    ? HexColor.fromHex(themeCfg.surveyItemTextColor)
                    : Colors.black),
            headline2: TextStyle(
                fontSize: themeCfg?.headline2Size ?? 60.0,
                color: themeCfg.msgPanelTextColor != null
                    ? HexColor.fromHex(themeCfg.msgPanelTextColor)
                    : Colors.black),
            headline3: TextStyle(
                fontSize: themeCfg?.headline3Size ?? 48.0,
                color: themeCfg.questionPanelTextColor != null
                    ? HexColor.fromHex(themeCfg.questionPanelTextColor)
                    : Colors.black),
            headline4: TextStyle(
                fontSize: themeCfg?.headline4Size ?? 34.0,
                color: themeCfg.dynamicIntroTextColor != null
                    ? HexColor.fromHex(themeCfg.dynamicIntroTextColor)
                    : Colors.black),
            headline5: TextStyle(
                fontSize: themeCfg?.headline5 ?? 24.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline6: TextStyle(
                fontSize: themeCfg?.headline6Size ?? 20.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            subtitle1: TextStyle(
                fontSize: themeCfg?.subtitle1Size ?? 16.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            subtitle2: TextStyle(
                fontSize: themeCfg?.subtitle2Size ?? 14.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            button: TextStyle(
                fontSize: themeCfg?.buttonSize ?? 14.0,
                color: themeCfg.buttonColor != null
                    ? HexColor.fromHex(themeCfg.buttonColor)
                    : Colors.green),
            caption: TextStyle(
                fontSize: themeCfg?.captionSize ?? 12.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            overline: TextStyle(
                fontSize: themeCfg?.overlineSize ?? 10.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
          )
          .apply(fontFamily: GoogleFonts.roboto().fontFamily),
      primaryTextTheme: GoogleFonts.robotoTextTheme()
          .copyWith(
            bodyText1: TextStyle(
                fontSize: themeCfg?.bodyText1Size ?? 16.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            bodyText2: TextStyle(
                fontSize: themeCfg?.bodyText2Size ?? 14.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline1: TextStyle(
                fontSize: themeCfg?.headline1Size ?? 80.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline2: TextStyle(
                fontSize: themeCfg?.headline2Size ?? 60.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline3: TextStyle(
                fontSize: themeCfg?.headline3Size ?? 48.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline4: TextStyle(
                fontSize: themeCfg?.headline4Size ?? 34.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline5: TextStyle(
                fontSize: themeCfg?.headline5 ?? 24.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            headline6: TextStyle(
                fontSize: themeCfg?.headline6Size ?? 20.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            subtitle1: TextStyle(
                fontSize: themeCfg?.subtitle1Size ?? 16.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            subtitle2: TextStyle(
                fontSize: themeCfg?.subtitle2Size ?? 14.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            button: TextStyle(
                fontSize: themeCfg?.buttonSize ?? 14.0,
                color: themeCfg.buttonTextColor != null
                    ? HexColor.fromHex(themeCfg.buttonTextColor)
                    : Colors.black),
            caption: TextStyle(
                fontSize: themeCfg?.captionSize ?? 12.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
            overline: TextStyle(
                fontSize: themeCfg?.overlineSize ?? 10.0,
                color: themeCfg.textColor != null
                    ? HexColor.fromHex(themeCfg.textColor)
                    : Colors.black),
          )
          .apply(fontFamily: GoogleFonts.roboto().fontFamily),
    );

final darkMaterialTheme = (ThemeCfg themeCfg) => _darkThemeData.copyWith(
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodyText1: TextStyle(fontSize: themeCfg?.bodyText1Size ?? 16.0),
        bodyText2: TextStyle(fontSize: themeCfg?.bodyText2Size ?? 14.0),
        headline1: TextStyle(fontSize: themeCfg?.headline1Size ?? 96.0),
        headline2: TextStyle(fontSize: themeCfg?.headline2Size ?? 60.0),
        headline3: TextStyle(fontSize: themeCfg?.headline3Size ?? 48.0),
        headline4: TextStyle(fontSize: themeCfg?.headline4Size ?? 34.0),
        headline5: TextStyle(fontSize: themeCfg?.headline5 ?? 24.0),
        headline6: TextStyle(fontSize: themeCfg?.headline6Size ?? 20.0),
        subtitle1: TextStyle(fontSize: themeCfg?.subtitle1Size ?? 16.0),
        subtitle2: TextStyle(fontSize: themeCfg?.subtitle2Size ?? 14.0),
        button: TextStyle(fontSize: themeCfg?.buttonSize ?? 14.0),
        caption: TextStyle(fontSize: themeCfg?.captionSize ?? 12.0),
        overline: TextStyle(fontSize: themeCfg?.overlineSize ?? 10.0),
      ),
      primaryTextTheme: GoogleFonts.robotoTextTheme().copyWith(
        bodyText1: TextStyle(fontSize: themeCfg?.bodyText1Size ?? 16.0),
        bodyText2: TextStyle(fontSize: themeCfg?.bodyText2Size ?? 14.0),
        headline1: TextStyle(fontSize: themeCfg?.headline1Size ?? 96.0),
        headline2: TextStyle(fontSize: themeCfg?.headline2Size ?? 60.0),
        headline3: TextStyle(fontSize: themeCfg?.headline3Size ?? 48.0),
        headline4: TextStyle(fontSize: themeCfg?.headline4Size ?? 34.0),
        headline5: TextStyle(fontSize: themeCfg?.headline5 ?? 24.0),
        headline6: TextStyle(fontSize: themeCfg?.headline6Size ?? 20.0),
        subtitle1: TextStyle(fontSize: themeCfg?.subtitle1Size ?? 16.0),
        subtitle2: TextStyle(fontSize: themeCfg?.subtitle2Size ?? 14.0),
        button: TextStyle(fontSize: themeCfg?.buttonSize ?? 14.0),
        caption: TextStyle(fontSize: themeCfg?.captionSize ?? 12.0),
        overline: TextStyle(fontSize: themeCfg?.overlineSize ?? 10.0),
      ),
    );
