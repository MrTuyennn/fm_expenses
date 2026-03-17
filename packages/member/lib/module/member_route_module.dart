import 'package:auto_route/auto_route.dart';

import 'member_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/module', 'lib/presentation/pages'])
class MemberRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MemberRoute.page, path: '/account'),
  ];
}
