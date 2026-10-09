import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'transaction', asExtension: false)
Future<void> configureTransactionDependencies() async => transaction(getIt);
