import 'dart:async';

import 'package:app/routers/auth_route_guard.dart';
import 'package:app/routers/base/navigator_observer.dart';
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:providers/providers.dart';
import 'package:service/service.dart';
import 'package:theme/theme.dart';

import 'routers/router.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  late final _router = AppRouter(authRouteGuard: AuthRouteGuard(context));
  late final _routerConfig = _router.config(
    navigatorObservers: () => [NavigatorObserverApp()],
  );
  StreamSubscription<void>? _loggedOutSubscription;

  @override
  void initState() {
    super.initState();
    // Refresh-token failed (or an explicit logout happened) somewhere mid-
    // session — reset auth state and kick straight back to login, instead
    // of waiting for the user to hit a guarded route on their own.
    _loggedOutSubscription = di<ITokenService>().onLoggedOut.listen((_) {
      di<UserBloc>().add(UserLoggedOut());
      _router.replaceAll([const LoginRoute()]);
    });
  }

  @override
  void dispose() {
    _loggedOutSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(isTablet: false).themeData,
      darkTheme: AppTheme.dark(isTablet: false).themeData,
      locale: Locale('vi', 'VN'),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      themeMode: ThemeMode.light,
      routerConfig: _routerConfig,
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
