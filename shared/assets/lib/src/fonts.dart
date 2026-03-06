import 'dart:ui' as ui;
import 'package:assets/assets.dart';
import 'package:flutter/material.dart';

TextStyle quicksand({
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<ui.Shadow>? shadows,
  List<ui.FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  textStyle ??= const TextStyle();
  textStyle = textStyle.copyWith(
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    fontFamily: FontFamily.quicksand,
  );
  return textStyle.copyWith();
}

TextTheme quicksandTextTheme([TextTheme? textTheme]) {
  textTheme ??= ThemeData.light().textTheme;
  return TextTheme(
    displayLarge: quicksand(textStyle: textTheme.displayLarge),
    displayMedium: quicksand(textStyle: textTheme.displayMedium),
    displaySmall: quicksand(textStyle: textTheme.displaySmall),
    headlineLarge: quicksand(textStyle: textTheme.headlineLarge),
    headlineMedium: quicksand(textStyle: textTheme.headlineMedium),
    headlineSmall: quicksand(textStyle: textTheme.headlineSmall),
    titleLarge: quicksand(textStyle: textTheme.titleLarge),
    titleMedium: quicksand(textStyle: textTheme.titleMedium),
    titleSmall: quicksand(textStyle: textTheme.titleSmall),
    bodyLarge: quicksand(textStyle: textTheme.bodyLarge),
    bodyMedium: quicksand(textStyle: textTheme.bodyMedium),
    bodySmall: quicksand(textStyle: textTheme.bodySmall),
    labelLarge: quicksand(textStyle: textTheme.labelLarge),
    labelMedium: quicksand(textStyle: textTheme.labelMedium),
    labelSmall: quicksand(textStyle: textTheme.labelSmall),
  );
}
