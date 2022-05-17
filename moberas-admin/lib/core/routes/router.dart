import 'package:auto_route/auto_route_annotations.dart';
import 'package:mobEras/ui/views/discharge/discharge_view.dart';
import 'package:mobEras/ui/views/dynamicSurvey/dynamic_survey_view.dart';
import 'package:mobEras/ui/views/home/home_view.dart';
import 'package:mobEras/ui/views/intro/moberas_video_intro_view.dart';
import 'package:mobEras/ui/views/login/login_view.dart';
import 'package:mobEras/ui/views/milestoneSurvey/milestone_survey_view.dart';
import 'package:mobEras/ui/views/pacient_form/pacient_form_view.dart';
import 'package:mobEras/ui/views/startup/startup_view.dart';
import 'package:mobEras/ui/views/tcle/tcle_view.dart';
import 'package:mobEras/ui/views/text_intro/text_intro_view.dart';
import 'package:mobEras/ui/views/validation_survey/validation_survey_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView),
    MaterialRoute(page: TextIntroView),
    MaterialRoute(page: TcleView),
    MaterialRoute(page: MobErasVideoIntroView),
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: MilestoneSurveyView),
    MaterialRoute(
      page: DynamicSurveyView,
    ),
    MaterialRoute(page: PacientFormView),
    MaterialRoute(page: DischargeView),
    MaterialRoute(page: ValidationSurveyView),
  ],
)
class $AppRouter {}
