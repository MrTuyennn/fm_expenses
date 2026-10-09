import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options_dev.dart' as dev_options;
import 'firebase_options_prod.dart' as prod_options;
import 'firebase_options_stag.dart' as stag_options;

/// Flip this to `true` once every flavor's `firebase_options_*.dart` has
/// been regenerated with real values via `flutterfire configure`
/// (see docs/release-pipeline.md). Left `false`, Firebase/Crashlytics are
/// skipped entirely so the app keeps building and running exactly as before.
const bool kFirebaseConfigured = false;

FirebaseOptions _optionsForCurrentFlavor() {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  switch (flavor) {
    case 'dev':
      return dev_options.DefaultFirebaseOptions.currentPlatform;
    case 'stag':
      return stag_options.DefaultFirebaseOptions.currentPlatform;
    default:
      return prod_options.DefaultFirebaseOptions.currentPlatform;
  }
}

/// Initializes Firebase and wires Crashlytics to catch both Flutter
/// framework errors and uncaught async errors. No-op until
/// [kFirebaseConfigured] is turned on.
Future<void> initializeFirebase() async {
  if (!kFirebaseConfigured) return;

  await Firebase.initializeApp(options: _optionsForCurrentFlavor());

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
