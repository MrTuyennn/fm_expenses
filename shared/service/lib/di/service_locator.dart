import '../remote/rest_client.dart';
import '../remote/rest_client.io.dart';

import 'package:get_it/get_it.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Register all dependencies used across packages/apps.
///
/// Call this once at app startup (before any UI).
void setupDI({String? baseUrl}) {
  if (sl.isRegistered<IRestClient>()) return;

  sl.registerLazySingleton<RestClient>(() => RestClient(baseUrl: baseUrl));
  sl.registerLazySingleton<IRestClient>(() => sl<RestClient>());
}

