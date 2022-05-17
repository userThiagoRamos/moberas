// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/views/discharge/discharge_view.dart';
import '../../ui/views/dynamicSurvey/dynamic_survey_view.dart';
import '../../ui/views/home/home_view.dart';
import '../../ui/views/intro/moberas_video_intro_view.dart';
import '../../ui/views/login/login_view.dart';
import '../../ui/views/milestoneSurvey/milestone_survey_view.dart';
import '../../ui/views/pacient_form/pacient_form_view.dart';
import '../../ui/views/startup/startup_view.dart';
import '../../ui/views/tcle/tcle_view.dart';
import '../../ui/views/text_intro/text_intro_view.dart';
import '../../ui/views/validation_survey/validation_survey_view.dart';

class Routes {
  static const String loginView = '/login-view';
  static const String textIntroView = '/text-intro-view';
  static const String tcleView = '/tcle-view';
  static const String mobErasVideoIntroView = '/mob-eras-video-intro-view';
  static const String startupView = '/';
  static const String homeView = '/home-view';
  static const String milestoneSurveyView = '/milestone-survey-view';
  static const String dynamicSurveyView = '/dynamic-survey-view';
  static const String pacientFormView = '/pacient-form-view';
  static const String dischargeView = '/discharge-view';
  static const String validationSurveyView = '/validation-survey-view';
  static const all = <String>{
    loginView,
    textIntroView,
    tcleView,
    mobErasVideoIntroView,
    startupView,
    homeView,
    milestoneSurveyView,
    dynamicSurveyView,
    pacientFormView,
    dischargeView,
    validationSurveyView,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.textIntroView, page: TextIntroView),
    RouteDef(Routes.tcleView, page: TcleView),
    RouteDef(Routes.mobErasVideoIntroView, page: MobErasVideoIntroView),
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.milestoneSurveyView, page: MilestoneSurveyView),
    RouteDef(Routes.dynamicSurveyView, page: DynamicSurveyView),
    RouteDef(Routes.pacientFormView, page: PacientFormView),
    RouteDef(Routes.dischargeView, page: DischargeView),
    RouteDef(Routes.validationSurveyView, page: ValidationSurveyView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    TextIntroView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TextIntroView(),
        settings: data,
      );
    },
    TcleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TcleView(),
        settings: data,
      );
    },
    MobErasVideoIntroView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MobErasVideoIntroView(),
        settings: data,
      );
    },
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    MilestoneSurveyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MilestoneSurveyView(),
        settings: data,
      );
    },
    DynamicSurveyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DynamicSurveyView(),
        settings: data,
      );
    },
    PacientFormView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PacientFormView(),
        settings: data,
      );
    },
    DischargeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DischargeView(),
        settings: data,
      );
    },
    ValidationSurveyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ValidationSurveyView(),
        settings: data,
      );
    },
  };
}
