import 'package:account/account.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/home.dart';
import 'package:l10n/l10n.dart';
import 'package:member/member.dart';
import 'package:transaction/transaction.dart';

import '../widgets/navigation_bar.dart';
import '../widgets/navigation_bar_item.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const routes = [
    HomeRoute(),
    TransactionRoute(),
    MemberRoute(),
    AccountRoute(),
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return AutoTabsRouter(
      routes: routes,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final index = tabsRouter.activeIndex;

        final navBars = [
          NavigationBarItem(
            label: l10n?.txt_home,
            icon: Icons.home,
            isActive: routes[index].routeName == HomeRoute.name,
          ),
          NavigationBarItem(
            label: l10n?.txt_transaction,
            icon: Icons.menu_book_rounded,
            isActive: routes[index].routeName == TransactionRoute.name,
          ),
          NavigationBarItem(
            label: l10n?.txt_member,
            icon: Icons.supervisor_account_rounded,
            isActive: routes[index].routeName == MemberRoute.name,
          ),
          NavigationBarItem(
            label: l10n?.txt_account,
            icon: Icons.account_circle_sharp,
            isActive: routes[index].routeName == AccountRoute.name,
          ),
        ];

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            body: child,
            bottomNavigationBar: NavigationBarCustom(
              navBars: navBars,
              onChange: (i) {
                tabsRouter.setActiveIndex(i);
              },
            ),
          ),
        );
      },
    );
  }
}
