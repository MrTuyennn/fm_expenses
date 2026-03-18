import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providers/providers.dart';
import 'package:service/service.dart';
import 'package:storage/storage.dart';

import './app_container.dart';
import 'module/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Storage.instance.initialize();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<AuthLoginBloc>()),
        BlocProvider(
          lazy: false,
          create: (context) => di<UserBloc>()..add(GetUserEvent()),
        ),
      ],
      child: AppContainer(),
    );
  }
}
