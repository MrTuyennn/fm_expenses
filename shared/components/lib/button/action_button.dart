import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final Widget? icon;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 52,
    this.borderRadius = 12,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? appColors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.md),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: appColors.white,
                ),
              )
            : icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: 8),
                  Text(label, style: textStyle),
                ],
              )
            : Text(label, style: textStyle),
      ),
    );
  }
}
