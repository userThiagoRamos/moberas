import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// Important. Impore the locator.iconfig.dart file
import 'locator.config.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async => $initGetIt(locator);
