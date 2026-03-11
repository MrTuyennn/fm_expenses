import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.hintText = '',
    this.label = '',
    this.controller,
  });

  final String hintText;
  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;

    return Column(
      spacing: AppDimens.sm,
      crossAxisAlignment: .start,
      children: [
        Text(
          label,
          style: appTextTheme.body.copyWith(color: appColors.gray[700]),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: appTextTheme.body.copyWith(color: appColors.gray[700]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.gray[400]!),
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.gray[400]!),
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
          ),
        ),
      ],
    );
  }
}
