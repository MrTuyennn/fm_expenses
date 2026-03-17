import 'package:flutter/material.dart';
import 'package:main/presentation/widgets/navigation_bar_item.dart';
import 'package:theme/theme.dart';

class NavigationBarCustom extends StatelessWidget {
  const NavigationBarCustom({super.key, required this.navBars, this.onChange});

  final Iterable<NavigationBarItem> navBars;
  final void Function(int index)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimens.lg,
        bottom: context.defaultBottomQueryPadding() - 16,
      ),
      child: Row(
        children: [
          for (int i = 0; i < navBars.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onChange!(i);
                },
                child: navBars.elementAt(i),
              ),
            ),
        ],
      ),
    );
  }
}
