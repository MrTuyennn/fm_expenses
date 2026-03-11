import 'package:app/routers/auth_route_guard.dart';
import 'package:app/routers/base/navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:theme/theme.dart';

import 'routers/router.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final AppRouter router = AppRouter(authRouteGuard: AuthRouteGuard());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(isTablet: false).themeData,
      darkTheme: AppTheme.dark(isTablet: false).themeData,
      locale: Locale('vi', 'VN'),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      themeMode: ThemeMode.light,
      routerConfig: router.config(
        navigatorObservers: () => [NavigatorObserverApp()],
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
