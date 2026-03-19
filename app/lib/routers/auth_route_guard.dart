import 'dart:async';

import 'package:app/routers/base/base_route_guard.dart';
import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providers/providers.dart';

/// [_closure] - closure to be ensure that the excute once
Future<dynamic>? _closure;

class AuthRouteGuard extends BaseRouteGuard {
  AuthRouteGuard(this.context);
  BuildContext context;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    UserBloc userBloc = context.read<UserBloc>();
    Future<bool> isAuth() async {
      if (userBloc.state.userType == UserType.success) return true;
      if (userBloc.state.userType == UserType.error) return false;

      // Nếu đang loading thì mới chờ stream
      final state = await userBloc.stream.firstWhere(
        (s) => s.userType == UserType.success || s.userType == UserType.error,
      );

      return state.userType == UserType.success;
    }

    final authenticated = await isAuth();

    if (authenticated) {
      resolver.next();
      return;
    }

    _closure ??= router.push(LoginRoute());

    await _closure?.then((_) => _closure = null);

    if (authenticated && resolver.routeName != router.current.name) {
      resolver.next();
      return;
    }
  }
}
