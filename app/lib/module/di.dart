import 'package:app/module/di.config.dart';
import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:providers/providers.dart';
import 'package:service/service.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await configureServiceDependencies();
  await configureAuthDependencies();
  await configureUserDependencies();
  getIt.init();
}
