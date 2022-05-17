import 'package:auto_route/auto_route_annotations.dart';
import 'package:moberas_dashboard/features/login/ui/login_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/dynamic/dynamic_chart_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/dynamic/dynamic_report_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/milestone/milestone_report_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_profile_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_view.dart';
import 'package:moberas_dashboard/features/pacient/ui/survey_app/survey_app_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: PacientView),
    MaterialRoute(page: PacientThemeView),
    MaterialRoute(page: PacientProfileView),
    MaterialRoute(page: DynamicReportView),
    MaterialRoute(page: MilestoneReportView),
    MaterialRoute(page: DynamicChartView),
    MaterialRoute(page: SurveyAppView),
  ],
)
class $AppRouter {}
