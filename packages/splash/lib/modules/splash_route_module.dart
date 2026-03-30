import 'package:auto_route/auto_route.dart';
import 'package:splash/modules/splash_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/presentation/pages', 'lib/module'])
class SplashRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: SplashRoute.page, path: '/', initial: true)];
}
