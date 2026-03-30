import 'package:account/account.dart';
import 'package:app/routers/guard.dart';
import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:home/home.dart';
import 'package:main/main.dart';
import 'package:member/member.dart';
import 'package:splash/splash.dart';
import 'package:transaction/transaction.dart';

@AutoRouterConfig(generateForDir: ['lib/modules', 'lib/app/presentation/pages'])
class AppRouter extends RootStackRouter {
  AppRouter({required this.authRouteGuard});
  final AuthRouteGuard authRouteGuard;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    ...SplashRouteModule().routes,
    CustomRoute(
      path: '/main',
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: TransactionRoute.page, path: 'transaction'),
        AutoRoute(page: MemberRoute.page, path: 'member'),
        AutoRoute(page: AccountRoute.page, path: 'account'),
      ],
      guards: [authRouteGuard],
    ),
    ...AuthRouteModule().routes,
  ];
}
