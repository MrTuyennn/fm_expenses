import 'package:app_logger/logger.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

final class NavigatorObserverApp extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    logger.i('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.e('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.d('Tab route re-visited: ${route.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.i('Pop: ${previousRoute?.settings.name}');
  }
}
