import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobEras/core/local_setup.dart';
import 'package:mobEras/core/localization/localization.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/managers/core_manager.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/firebase/analytics_service.dart';
import 'package:mobEras/core/services/theme/theme_service.dart';
import 'package:mobEras/core/services/theme/theme_service_interface.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:mobEras/ui/shared/themes.dart' as themes;
import 'package:mobEras/ui/widgets/dialogs/milestone/mlt_confirm_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/models/theme_cfg.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await SystemChrome.setEnabledSystemUIOverlays([]);

  setupLogger();
  
  await setupDialogUi();
  // final _fcmService = locator<LocalNotificationService>();
  // await _fcmService.initializeLocalNotifications();
  // await _fcmService.createNotificationChannel();

  runZonedGuarded(() {
    runApp(
      MyApp(),
    );
  }, (Object error, StackTrace stack) {
    Crashlytics.instance.recordError(error, stack);
  });
}

ThemeService themeService = locator<IThemeService>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeCfg>(
      initialData: ThemeCfg.defaultTheme(),
      stream: themeService.themeCfg$,
      builder: (context, snapshot) => snapshot.hasData
          ? CoreManager(
              child: MaterialApp(
                showSemanticsDebugger: false,
                debugShowCheckedModeBanner: false,
                theme: themes.primaryMaterialTheme(snapshot.data),
                darkTheme: themes.primaryMaterialTheme(snapshot.data),
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                localeResolutionCallback: loadSupportedLocals,
                onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
                title: 'MobEras',
                builder: ExtendedNavigator.builder<AppRouter>(
                  router: AppRouter(),
                  navigatorKey: locator<NavigationService>().navigatorKey,
                  initialRoute: Routes.startupView,
                  observers: [locator<AnalyticsService>().getAnalyticsObserver()],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
