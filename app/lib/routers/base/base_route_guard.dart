import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

abstract class BaseRouteGuard extends AutoRouteGuard {
  const BaseRouteGuard({required this.context});
  final BuildContext context;
}
