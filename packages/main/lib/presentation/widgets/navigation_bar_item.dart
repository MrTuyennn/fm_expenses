import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    this.label,
    this.isActive = false,
    this.icon,
  });

  final String? label;
  final bool isActive;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;

    final color = isActive ? appColors.green[700] : appColors.gray;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(
          label.toString(),
          style: appTextTheme.footnote.copyWith(color: color),
        ),
      ],
    );
  }
}
