import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> lsItems;
  final Function(T) onChanged;
  const CustomDropdown({super.key, required this.lsItems, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appColors = theme.appColors;
    final appTextTheme = theme.appTextTheme;
    return DropdownMenu(
      textStyle: appTextTheme.callout,
      initialSelection: lsItems.first.value,
      dropdownMenuEntries: lsItems,
      trailingIcon: Icon(Icons.keyboard_arrow_down),
      selectedTrailingIcon: Icon(Icons.keyboard_arrow_up),
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(maxHeight: 48),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimens.md)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.gray[200]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: appColors.gray[400]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.gray[200]!),
          borderRadius: BorderRadius.circular(AppDimens.md),
        ),
      ),
      onSelected: (value) {},
    );
  }
}
