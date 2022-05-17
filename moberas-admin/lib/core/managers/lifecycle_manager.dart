import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/connectivity/connectivity_service.dart';
import 'package:mobEras/core/services/location/location_service.dart';
import 'package:mobEras/core/services/profile/profile_service.dart';
import 'package:mobEras/core/services/stoppable_service.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';

/// A manager to start/stop [StoppableService]s when the app goes/returns into/from the background
class LifeCycleManager extends StatefulWidget {
  final Widget child;

  const LifeCycleManager({Key key, this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  List<StoppableService> servicesToManage = [
    locator<ConnectivityService>(),
    locator<LocationService>(),
  ];

  final _profileService = locator<ProfileService>();

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Logger.d('App life cycle change to $state');
    servicesToManage.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
    if (state == AppLifecycleState.resumed) {
      unawaited(_profileService.setUserOnlineStatus(true));
    } else {
      unawaited(_profileService.setUserOnlineStatus(false));
    }
  }
}
