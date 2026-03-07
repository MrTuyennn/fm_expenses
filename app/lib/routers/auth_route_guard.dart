import 'dart:async';

import 'package:app/routers/base/base_route_guard.dart';
import 'package:auth/modules/auth_route_module.gr.dart';
import 'package:auto_route/auto_route.dart';

/// [_closure] - closure to be ensure that the excute once
Future<dynamic>? _closure;

class AuthRouteGuard extends BaseRouteGuard {
  AuthRouteGuard({required super.context});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isAuth() => false;
    // ref.read(appStateProvider.select((value) => value.isAuthencation));

    if (isAuth()) {
      resolver.next();
      return;
    }

    _closure ??= router.push(LoginRoute());

    await _closure?.then((_) => _closure = null);

    if (isAuth() && resolver.routeName != router.current.name) {
      resolver.next();
      return;
    }
  }
}
