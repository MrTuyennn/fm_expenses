import 'package:auth/modules/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'auth', asExtension: false)
Future<void> configureAuthDependencies() async => auth(getIt);
