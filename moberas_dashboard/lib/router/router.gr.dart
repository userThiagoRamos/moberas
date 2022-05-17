// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/login/models/user_profile.dart';
import '../features/login/ui/login_view.dart';
import '../features/pacient/ui/dynamic/dynamic_report_view.dart';
import '../features/pacient/ui/milestone/milestone_report_view.dart';
import '../features/pacient/ui/pacient_profile_view.dart';
import '../features/pacient/ui/pacient_theme_view.dart';
import '../features/pacient/ui/pacient_view.dart';

class Routes {
  static const String loginView = '/';
  static const String pacientView = '/pacient-view';
  static const String pacientThemeView = '/pacient-theme-view';
  static const String pacientProfileView = '/pacient-profile-view';
  static const String dynamicReportView = '/dynamic-report-view';
  static const String milestoneReportView = '/milestone-report-view';
  static const all = <String>{
    loginView,
    pacientView,
    pacientThemeView,
    pacientProfileView,
    dynamicReportView,
    milestoneReportView,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.pacientView, page: PacientView),
    RouteDef(Routes.pacientThemeView, page: PacientThemeView),
    RouteDef(Routes.pacientProfileView, page: PacientProfileView),
    RouteDef(Routes.dynamicReportView, page: DynamicReportView),
    RouteDef(Routes.milestoneReportView, page: MilestoneReportView),
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
    PacientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PacientView(),
        settings: data,
      );
    },
    PacientThemeView: (data) {
      final args = data.getArgs<PacientThemeViewArguments>(
        orElse: () => PacientThemeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PacientThemeView(profile: args.profile),
        settings: data,
      );
    },
    PacientProfileView: (data) {
      final args = data.getArgs<PacientProfileViewArguments>(
        orElse: () => PacientProfileViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => PacientProfileView(profile: args.profile),
        settings: data,
      );
    },
    DynamicReportView: (data) {
      final args = data.getArgs<DynamicReportViewArguments>(
        orElse: () => DynamicReportViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DynamicReportView(profile: args.profile),
        settings: data,
      );
    },
    MilestoneReportView: (data) {
      final args = data.getArgs<MilestoneReportViewArguments>(
        orElse: () => MilestoneReportViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MilestoneReportView(profile: args.profile),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PacientThemeView arguments holder class
class PacientThemeViewArguments {
  final UserProfile profile;
  PacientThemeViewArguments({this.profile});
}

/// PacientProfileView arguments holder class
class PacientProfileViewArguments {
  final UserProfile profile;
  PacientProfileViewArguments({this.profile});
}

/// DynamicReportView arguments holder class
class DynamicReportViewArguments {
  final UserProfile profile;
  DynamicReportViewArguments({this.profile});
}

/// MilestoneReportView arguments holder class
class MilestoneReportViewArguments {
  final UserProfile profile;
  MilestoneReportViewArguments({this.profile});
}
