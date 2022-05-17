// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:moberas_dashboard/features/activities/services/activities_services.dart';
import 'package:moberas_dashboard/features/login/services/authentication_service_impl.dart';
import 'package:moberas_dashboard/features/login/services/authentication_service.dart';
import 'package:moberas_dashboard/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_impl.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_theme_service_impl.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_theme_service_interface.dart';
import 'package:moberas_dashboard/features/response/service/response_service_impl.dart';
import 'package:moberas_dashboard/features/response/service/response_service_interface.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<IPacientService>(() => IPacientServiceImpl());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);

  //Eager singletons must be registered in the right order
  g.registerSingleton<ActivitiesServices>(ActivitiesServices());
  g.registerSingleton<AuthenticationService>(AuthenticationServiceImpl());
  g.registerSingleton<IPacientThemeInterface>(PacientThemeServiceImpl());
  g.registerSingleton<IResponseService>(ResponseService());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
