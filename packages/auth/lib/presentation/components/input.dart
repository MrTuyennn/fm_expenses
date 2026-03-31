import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.hintText = '',
    this.label = '',
    this.controller,
    this.disabled = false,
    this.errorText = '',
  });

  final String hintText;
  final String label;
  final TextEditingController? controller;
  final bool disabled;
  final String? errorText;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;

    return Column(
      spacing: AppDimens.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: appTextTheme.body.copyWith(color: appColors.gray[700]),
        ),
        TextField(
          controller: controller,
          enabled: !disabled,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: appTextTheme.body.copyWith(color: appColors.gray[700]),
            errorText: _hasError ? errorText : null,
            errorStyle: appTextTheme.body.copyWith(color: appColors.red),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _hasError ? appColors.red : appColors.gray[400]!,
              ),
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _hasError ? appColors.red : appColors.gray[400]!,
              ),
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.gray[200]!),
              borderRadius: BorderRadius.circular(AppDimens.md),
            ),
            filled: disabled,
            fillColor: disabled ? appColors.gray[100] : null,
          ),
        ),
      ],
    );
  }
}
