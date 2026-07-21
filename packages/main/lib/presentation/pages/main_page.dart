import 'package:account/account.dart';
import 'package:app_logger/logger.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import 'package:l10n/l10n.dart';
import 'package:member/member.dart';
import 'package:transaction/transaction.dart';

import '../bloc/main_navigation_bloc.dart';
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

    return BlocProvider(
      create: (_) => MainNavigationBloc(),
      child: AutoTabsRouter(
        routes: routes,
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);

          return BlocConsumer<MainNavigationBloc, MainNavigationState>(
            listener: (context, state) {
              tabsRouter.setActiveIndex(state.selectedIndex);
            },
            builder: (context, state) {
              final index = state.selectedIndex;
              logger.e(index);

              final navBars = [
                NavigationBarItem(
                  label: l10n?.txt_home,
                  icon: Icons.home,
                  isActive: index == 0,
                ),
                NavigationBarItem(
                  label: l10n?.txt_transaction,
                  icon: Icons.menu_book_rounded,
                  isActive: index == 1,
                ),
                NavigationBarItem(
                  label: l10n?.txt_member,
                  icon: Icons.supervisor_account_rounded,
                  isActive: index == 2,
                ),
                NavigationBarItem(
                  label: l10n?.txt_account,
                  icon: Icons.account_circle_sharp,
                  isActive: index == 3,
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
                      context.read<MainNavigationBloc>().add(
                        MainNavigationEvent.changeIndex(i),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
