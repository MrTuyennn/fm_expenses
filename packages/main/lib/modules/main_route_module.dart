import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(generateForDir: ['lib/presentation/pages', 'lib/module'])
class MainRouteModule extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [];
}
