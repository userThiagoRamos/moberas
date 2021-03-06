import 'package:json_annotation/json_annotation.dart';

part 'theme_cfg.g.dart';

@JsonSerializable()
class ThemeCfg {
  double bodyText1Size;

  double bodyText2Size;

  double headline1Size;

  double headline2Size;

  double headline3Size;

  double headline4Size;

  double headline5;

  double headline6Size;

  double subtitle1Size;

  double subtitle2Size;

  double buttonSize;

  double captionSize;

  double overlineSize;
  String primaryColor;
  String accentColor;
  String textColor;
  String buttonColor;
  String pushContainerColor;
  String milestoneTileColor;
  String cardColor;
  String msgPanelTextColor;
  String questionPanelTextColor;
  String surveyItemTextColor;
  String dynamicIntroTextColor;
  String buttonTextColor;

  ThemeCfg(
      {this.bodyText1Size,
      this.bodyText2Size,
      this.headline1Size,
      this.headline2Size,
      this.headline3Size,
      this.headline4Size,
      this.headline5,
      this.headline6Size,
      this.subtitle1Size,
      this.subtitle2Size,
      this.buttonSize,
      this.captionSize,
      this.overlineSize,
      this.primaryColor,
      this.accentColor,
      this.textColor,
      this.buttonColor,
      this.pushContainerColor,
      this.milestoneTileColor,
      this.cardColor,
      this.msgPanelTextColor,
      this.questionPanelTextColor,
      this.surveyItemTextColor,
      this.dynamicIntroTextColor,
      this.buttonTextColor});

  factory ThemeCfg.fromJson(Map<String, dynamic> json) =>
      _$ThemeCfgFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeCfgToJson(this);

  factory ThemeCfg.defaultTheme() => ThemeCfg(
      accentColor: '#ff2196f3',
      bodyText1Size: 22.0,
      bodyText2Size: 14.0,
      buttonColor: '#ff004d40',
      buttonSize: 32.0,
      buttonTextColor: '#ffe8f5e9',
      captionSize: 12.0,
      cardColor: '#ff81d4fa',
      dynamicIntroTextColor: '#02b5b5',
      headline1Size: 38.0,
      headline2Size: 48.0,
      headline3Size: 38.0,
      headline4Size: 35.0,
      headline5: 25.0,
      headline6Size: 38.0,
      msgPanelTextColor: '#ffffffff',
      overlineSize: 10.0,
      primaryColor: '#ffb3e5fc',
      pushContainerColor: '#02b5b5',
      questionPanelTextColor: '#ff000000',
      subtitle1Size: 16.0,
      subtitle2Size: 14.0,
      surveyItemTextColor: '#ff000000',
      textColor: '#000000');
}
