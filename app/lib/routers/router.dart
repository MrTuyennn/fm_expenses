import 'package:app/routers/guard.dart';
import 'package:auth/modules/auth_route_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:main/modules/main_route_module.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/modules', 'lib/app/presentation/pages'])
class AppRouter extends RootStackRouter {
  AppRouter({required this.authRouteGuard});
  final AuthRouteGuard authRouteGuard;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      path: '/main',
      initial: true,
      page: MainRoute.page,
      // children: [
      //   AutoRoute(page: HomeRoute.page, path: 'home'),
      //   AutoRoute(page: NotificationRoute.page, path: 'notification'),
      //   AutoRoute(page: AccountRoute.page, path: 'account'),
      // ],
      guards: [authRouteGuard],
    ),
    ...AuthRouteModule().routes,
  ];
}
