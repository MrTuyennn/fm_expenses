import 'package:app/routers/auth_route_guard.dart';
import 'package:app/routers/base/navigator_observer.dart';
import 'package:app/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:theme/theme.dart';

class AppContainer extends StatelessWidget {
  AppContainer({super.key});

  final _appRouter = AppRouter(authRouteGuard: AuthRouteGuard());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light(isTablet: false).themeData,
      darkTheme: AppTheme.dark(isTablet: false).themeData,
      locale: Locale('vi', 'VN'),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      themeMode: ThemeMode.light,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [NavigatorObserverApp()],
      ),
    );
  }
}
