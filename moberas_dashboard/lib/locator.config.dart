// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'features/activities/services/activities_services.dart';
import 'features/login/services/authentication_service.dart';
import 'features/login/services/authentication_service_impl.dart';
import 'features/pacient/services/pacient_service_interface.dart';
import 'features/pacient/services/pacient_service_impl.dart';
import 'features/pacient/services/pacient_theme_service_interface.dart';
import 'features/response/service/response_service_interface.dart';
import 'features/pacient/services/pacient_theme_service_impl.dart';
import 'features/response/service/response_service_impl.dart';
import 'third_party_services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<IPacientService>(() => IPacientServiceImpl());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);

  // Eager singletons must be registered in the right order
  gh.singleton<ActivitiesServices>(ActivitiesServices());
  gh.singleton<AuthenticationService>(AuthenticationServiceImpl());
  gh.singleton<IPacientThemeInterface>(PacientThemeServiceImpl());
  gh.singleton<IResponseService>(ResponseService());
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
