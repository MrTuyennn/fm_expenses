import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class InputSearch extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const InputSearch({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: AppDimens.slg, horizontal: AppDimens.slg),
        hintText: hintText,
        hintStyle: appTextTheme.callout.copyWith(color: appColors.gray[500]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimens.md)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.gray[200]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.gray[400]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.gray[200]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
      ),
    );
  }
}
