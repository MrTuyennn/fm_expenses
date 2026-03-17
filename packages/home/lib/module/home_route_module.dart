import 'package:auto_route/auto_route.dart';

import 'home_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/module', 'lib/presentation/pages'])
class HomeRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home'),
  ];
}
