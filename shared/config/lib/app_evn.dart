import 'dart:io';

import 'package:flutter/foundation.dart';

enum Flavor { stage, production }

@immutable
class Env {
  const Env._({
    required this.endpoint,
    required this.flavor,
    required this.appId,
  });

  /// Backend host, e.g. `http://10.0.2.2:8080`. Always pass this explicitly
  /// for a real device or production:
  /// `--dart-define=API_BASE_URL=http://<lan-ip>:8080`.
  /// Without it, falls back to the Android-emulator/iOS-simulator default so
  /// `flutter run` keeps working out of the box.
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get _defaultApiBaseUrl =>
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080';

  factory Env.of() {
    final flavor = Flavor.values.fromString(
      const String.fromEnvironment('FLAVOR'),
      defaultValue: Flavor.production,
    );

    final baseUrl = _apiBaseUrl.isNotEmpty ? _apiBaseUrl : _defaultApiBaseUrl;

    return Env._(
      endpoint: '$baseUrl/api/v1',
      flavor: flavor,
      appId: 'fm.expenses',
    );
  }

  static final Env instance = Env.of();

  final String endpoint;
  final Flavor flavor;
  final String appId;

  String get defaultConfigFilePath =>
      'packages/config/assets/${flavor.name}/remote_config_default_values.json';

  bool get supportDebugKits => kReleaseMode && flavor != Flavor.production;
}

extension EnumByName<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name. Such a value must be found.
  T fromString(String name, {T? defaultValue}) {
    for (var value in this) {
      if (value.name == name) return value;
    }
    if (defaultValue == null) {
      throw ArgumentError.value(name, 'name', 'No enum value with that name');
    }

    return defaultValue;
  }
}
