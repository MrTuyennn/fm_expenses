import 'package:auto_route/auto_route.dart';
import 'package:main/modules/main_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentation/pages', 'lib/module'])
class MainRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, path: '/main'),
  ];
}
