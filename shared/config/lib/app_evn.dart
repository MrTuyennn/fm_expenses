import 'package:flutter/foundation.dart';

enum Flavor { stage, production }

@immutable
class Env {
  const Env._({
    required this.endpoint,
    required this.flavor,
    required this.appId,
  });

  factory Env.of() {
    final flavor = Flavor.values.fromString(
      const String.fromEnvironment('FLAVOR'),
      defaultValue: Flavor.production,
    );

    switch (flavor) {
      case Flavor.stage:
        return Env._stage();
      case Flavor.production:
        return Env._prd();
    }
  }

  factory Env._stage() {
    return Env._(
      endpoint: 'https://hf-tau.vercel.app/api/v1',
      flavor: Flavor.stage,
      appId: 'fm.expenses',
    );
  }

  factory Env._prd() {
    return Env._(
      endpoint: 'https://hf-tau.vercel.app/api/v1/production',
      flavor: Flavor.production,
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
