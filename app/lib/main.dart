import 'package:flutter/material.dart';
import 'package:service/service.dart';
import 'package:storage/storage.dart';

import './app_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDI(baseUrl: 'https://hf-tau.vercel.app/api');
  await Storage.instance.initialize();

  runApp(
    /// handle more func before open app
    AppContainer(),
  );
}
