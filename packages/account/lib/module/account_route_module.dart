import 'package:auto_route/auto_route.dart';

import 'account_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/module', 'lib/presentation/pages'])
class AccountRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AccountRoute.page, path: '/account'),
  ];
}
