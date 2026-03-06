import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._internal({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;
  factory Storage() {
    return _instance;
  }

  static final _instance = Storage._internal(
    secureStorage: const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  static bool _isInitialized = false;

  static Storage get instance => _instance;

  SharedPreferences? _preferences;
  SharedPreferences? get preferences => _preferences;

  final FlutterSecureStorage _secureStorage;
  FlutterSecureStorage get secureStorage => _secureStorage;

  Box? _vaultBox;
  Box? get vaultBox {
    if (!_isInitialized) {
      throw StorageInitializationError(
        'You must call `Storage.initialize()` before use this',
      );
    }
    return _vaultBox;
  }

  Future<void> _clearSecureStorageOnReinstall() async {
    String key = 'hasRunBefore';
    SharedPreferences prefs =
        _preferences ?? await SharedPreferences.getInstance();

    if (!(prefs.getBool(key) ?? false)) {
      await secureStorage.deleteAll();
      prefs.setBool(key, true);
    }
  }

  Future<void> initialize() async {
    if (_isInitialized) return;

    _preferences = await SharedPreferences.getInstance();
    await Hive.initFlutter();

    await _clearSecureStorageOnReinstall();

    const encryptedSecretKey = 'encrypted_secret_key';
    const vaultBox = 'vault_box';

    String? encryptionKeyString = await _secureStorage.read(
      key: encryptedSecretKey,
    );

    if (encryptionKeyString == null || encryptionKeyString.isEmpty) {
      encryptionKeyString = base64UrlEncode(Hive.generateSecureKey());
      await _secureStorage.write(
        key: encryptedSecretKey,
        value: encryptionKeyString,
      );
    }

    final encryptionKeyUnit8List = base64Url.decode(encryptionKeyString);
    _vaultBox = await Hive.openBox(
      vaultBox,
      encryptionCipher: HiveAesCipher(encryptionKeyUnit8List),
    );

    _isInitialized = true;
  }
}

class StorageInitializationError extends Error {
  StorageInitializationError(this.message);

  final String message;

  @override
  String toString() => 'Storage Initialization Error: $message';
}
