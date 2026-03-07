import 'package:auth/modules/auth_route_module.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['lib/presentation/pages', 'lib/module'])
class AuthRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
  ];
}
