// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'services/activity/activity_service_impl.dart';
import 'services/firebase/analytics_service.dart';
import 'services/audio/audio_service.dart';
import 'services/auth/authentication_service.dart';
import 'services/auth/authentication_service_impl.dart';
import 'services/firebase/cloud_storage_service.dart';
import 'services/connectivity/connectivity_service.dart';
import 'services/connectivity/connectivity_service_impl.dart';
import 'services/activity/activity_service.dart';
import '../ui/widgets/appbar/service/appbar_service_interface.dart';
import 'services/milestone/milestone_service_interface.dart';
import 'services/msgpanel/msg_panel_service_interface.dart';
import 'services/messages/pacient_message_interface.dart';
import 'services/reward/reward_service_interface.dart';
import 'services/scale/IScaleService.dart';
import 'services/survey/survey_service_interface.dart';
import 'services/theme/theme_service_interface.dart';
import 'services/fcm/local_notification_service.dart';
import 'services/location/location_service.dart';
import 'services/location/location_service_impl.dart';
import 'services/milestone/milestone_service.dart';
import 'services/msgpanel/msg_panel_service_impl.dart';
import 'services/messages/pacient_message_impl.dart';
import 'services/pedometer/pedometer_service.dart';
import 'services/pedometer/pedometer_service_impl.dart';
import 'services/profile/profile_service.dart';
import 'services/profile/profile_service_impl.dart';
import 'services/firebase/push_notification_service.dart';
import 'services/reward/reward_service.dart';
import 'services/scale/scale_service.dart';
import 'services/surveyManager/survey_manager_service.dart';
import 'services/schedule/survey_schedule_service.dart';
import 'services/survey/survey_service.dart';
import 'services/theme/theme_service.dart';
import 'services/third_party_services_module.dart';
import '../ui/widgets/appbar/service/appbar_service_impl.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<CloudStorageService>(() => CloudStorageService());
  gh.factory<ConnectivityService>(() => ConnectivityServiceImpl());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.factory<IActivityService>(() => ActivityServiceImpl());
  gh.factory<IMilestoneService>(() => MilestoneService());
  gh.factory<IRewardService>(() => RewardService());
  gh.factory<IScaleService>(() => ScaleService());
  gh.factory<ISurveyService>(() => SurveyService());
  gh.factory<IThemeService>(() => ThemeService());
  gh.lazySingleton<LocationService>(() => LocationServiceImpl());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.factory<ProfileService>(() => ProfileServiceImpl());
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);

  // Eager singletons must be registered in the right order
  gh.singleton<AnalyticsService>(AnalyticsService());
  gh.singleton<AudioService>(AudioService());
  gh.singleton<IAppBarService>(UserStatusServiceImpl());
  gh.singleton<IMsgPanelService>(MsgService());
  gh.singleton<IPacientMessageService>(PacientMessageImpl());
  gh.singleton<LocalNotificationService>(LocalNotificationService());
  gh.singleton<PedometerService>(PedometerServiceImpl());
  gh.singleton<PushNotificationService>(PushNotificationService());
  gh.singleton<SurveyManagerService>(SurveyManagerService());
  gh.singleton<SurveyScheduleService>(
      SurveyScheduleService(get<ISurveyService>()));
  gh.singleton<AuthenticationService>(AuthenticationServiceImpl(
    get<SurveyScheduleService>(),
    get<AnalyticsService>(),
    get<NavigationService>(),
    get<LocationService>(),
    get<ProfileService>(),
  ));
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
