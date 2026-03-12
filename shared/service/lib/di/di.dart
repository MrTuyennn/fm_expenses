import 'di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'service', asExtension: false)
Future<void> configureServiceDependencies() async => service(getIt);
