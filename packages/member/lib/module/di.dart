import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'member', asExtension: false)
Future<void> configureMemberDependencies() async => member(getIt);
