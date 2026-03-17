import 'package:auto_route/auto_route.dart';

import 'transaction_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/module', 'lib/presentation/pages'])
class TransactionRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TransactionRoute.page, path: '/account'),
  ];
}
