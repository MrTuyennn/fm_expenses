import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:storage/storage.dart';

import './app_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDI(baseUrl: 'https://boa-fleet-mistakenly.ngrok-free.app/api/v1');
  await Storage.instance.initialize();

  runApp(
    /// handle more func before open app
    AppContainer(),
  );
}
