import 'package:flutter/material.dart';
import 'package:assets/assets.dart';

class AppColors extends ThemeExtension<AppColors> {
  AppColors({
    required this.active,
    required this.red,
    required this.blue,
    required this.slate,
    required this.green,
    required this.orange,
    required this.gray,
    required this.yellow,
    required this.amber,
    required this.cyan,
    required this.indigo,
    required this.pink,
    required this.violet,
    required this.emerald,
    required this.rose,
    required this.primaryA,
    required this.primaryB,
    required this.primaryC,
    required this.primaryCL,
    required this.primaryD,
    required this.black,
    required this.white,
    required this.semanticRed,
    required this.semanticGreen,
    required this.text,
    required this.textDisabled,
    required this.textBodyDefault,
    required this.textBodySub,
    required this.textTitle,
    required this.bodyActive,
    required this.bodyLink,
    required this.backgroundLightCyan,
    required this.border,
    required this.borderTextFieldFocused,
    required this.borderSubTitle,
    required this.activeButton,
    required this.disableButton,
    required this.primaryBlue,
  });

  factory AppColors.light() {
    return AppColors(
      active: ResColors.active,
      red: ResColors.red,
      blue: ResColors.blue,
      slate: ResColors.slate,
      green: ResColors.green,
      orange: ResColors.orange,
      emerald: ResColors.emerald,
      gray: ResColors.gray,
      yellow: ResColors.yellow,
      amber: ResColors.amber,
      cyan: ResColors.cyan,
      indigo: ResColors.indigo,
      pink: ResColors.pink,
      violet: ResColors.violet,
      rose: ResColors.rose,
      primaryA: ResColors.primaryA,
      primaryB: ResColors.primaryB,
      primaryC: ResColors.primaryC,
      primaryCL: ResColors.primaryCL,
      primaryD: ResColors.primaryD,
      black: ResColors.black,
      white: ResColors.white,
      semanticRed: ResColors.sematicRed,
      semanticGreen: ResColors.sematicGreen,
      text: ResColors.text,
      textDisabled: ResColors.textDisabled,
      textBodyDefault: ResColors.textBodyDefault,
      textBodySub: ResColors.textBodySub,
      textTitle: ResColors.textTitle,
      bodyActive: ResColors.bodyActive,
      bodyLink: ResColors.bodyLink,
      backgroundLightCyan: ResColors.backgroundLightCyan,
      border: ResColors.border,
      borderTextFieldFocused: ResColors.borderTextFieldFocused,
      borderSubTitle: ResColors.borderSubtitle,
      activeButton: ResColors.activeButton,
      disableButton: ResColors.disableButton,
      primaryBlue: ResColors.primaryBlue,
    );
  }

  factory AppColors.dark() {
    return AppColors.light();
  }

  /// Color change by course
  final ColorSwatch<int> active;
  final ColorSwatch<int> blue;
  final ColorSwatch<int> primaryA;
  final ColorSwatch<int> bodyActive;

  final ColorSwatch<int> slate;
  final ColorSwatch<int> gray;
  final ColorSwatch<int> orange;
  final ColorSwatch<int> yellow;
  final ColorSwatch<int> amber;
  final ColorSwatch<int> emerald;
  final ColorSwatch<int> cyan;
  final ColorSwatch<int> green;
  final ColorSwatch<int> indigo;
  final ColorSwatch<int> violet;
  final ColorSwatch<int> pink;
  final ColorSwatch<int> rose;
  final ColorSwatch<int> red;

  final ColorSwatch<int> primaryB;
  final ColorSwatch<int> primaryC;
  final ColorSwatch<int> primaryCL;
  final ColorSwatch<int> primaryD;

  final ColorSwatch<int> black;
  final ColorSwatch<int> white;

  final ColorSwatch<int> semanticRed;
  final ColorSwatch<int> semanticGreen;

  final ColorSwatch<int> text;
  final ColorSwatch<int> textDisabled;
  final ColorSwatch<int> textBodyDefault;
  final ColorSwatch<int> textBodySub;
  final ColorSwatch<int> textTitle;

  final ColorSwatch<int> bodyLink;

  final ColorSwatch<int> backgroundLightCyan;

  final ColorSwatch<int> border;
  final ColorSwatch<int> borderTextFieldFocused;
  final ColorSwatch<int> borderSubTitle;

  final ColorSwatch<int> disableButton;
  final ColorSwatch<int> activeButton;

  final ColorSwatch<int> primaryBlue;

  @override
  ThemeExtension<AppColors> copyWith({
    ColorSwatch<int>? active,
    ColorSwatch<int>? blue,
    ColorSwatch<int>? slate,
    ColorSwatch<int>? green,
    ColorSwatch<int>? orange,
    ColorSwatch<int>? gray,
    ColorSwatch<int>? redAccent,
    ColorSwatch<int>? yellow,
    ColorSwatch<int>? amber,
    ColorSwatch<int>? cyan,
    ColorSwatch<int>? indigo,
    ColorSwatch<int>? pink,
    ColorSwatch<int>? violet,
    ColorSwatch<int>? emerald,
    ColorSwatch<int>? rose,
    ColorSwatch<int>? primaryA,
    ColorSwatch<int>? primaryB,
    ColorSwatch<int>? primaryC,
    ColorSwatch<int>? primaryCL,
    ColorSwatch<int>? primaryD,
    ColorSwatch<int>? black,
    ColorSwatch<int>? white,
    ColorSwatch<int>? semanticRed,
    ColorSwatch<int>? semanticGreen,
    ColorSwatch<int>? text,
    ColorSwatch<int>? textDisabled,
    ColorSwatch<int>? textBodyDefault,
    ColorSwatch<int>? textBodySub,
    ColorSwatch<int>? textTitle,
    ColorSwatch<int>? bodyActive,
    ColorSwatch<int>? bodyLink,
    ColorSwatch<int>? backgroundLightCyan,
    ColorSwatch<int>? border,
    ColorSwatch<int>? borderTextFieldFocused,
    ColorSwatch<int>? borderSubTitle,
    ColorSwatch<int>? red,
    ColorSwatch<int>? activeButton,
    ColorSwatch<int>? disableButton,
    ColorSwatch<int>? primaryBlue,
  }) {
    return AppColors(
      active: active ?? this.active,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      slate: slate ?? this.slate,
      green: green ?? this.green,
      orange: orange ?? this.orange,
      gray: gray ?? this.gray,
      yellow: yellow ?? this.yellow,
      amber: amber ?? this.amber,
      cyan: cyan ?? this.cyan,
      indigo: indigo ?? this.indigo,
      pink: pink ?? this.pink,
      violet: violet ?? this.violet,
      emerald: emerald ?? this.emerald,
      rose: rose ?? this.rose,
      primaryA: primaryA ?? this.primaryA,
      primaryB: primaryB ?? this.primaryB,
      primaryC: primaryC ?? this.primaryC,
      primaryCL: primaryCL ?? this.primaryCL,
      primaryD: primaryD ?? this.primaryD,
      black: black ?? this.black,
      white: white ?? this.white,
      semanticRed: semanticRed ?? this.semanticRed,
      semanticGreen: semanticGreen ?? this.semanticGreen,
      text: text ?? this.text,
      textDisabled: textDisabled ?? this.textDisabled,
      textBodyDefault: textBodyDefault ?? this.textBodyDefault,
      textBodySub: textBodySub ?? this.textBodySub,
      textTitle: textTitle ?? this.textTitle,
      bodyActive: bodyActive ?? this.bodyActive,
      bodyLink: bodyLink ?? this.bodyLink,
      backgroundLightCyan: backgroundLightCyan ?? this.backgroundLightCyan,
      border: border ?? this.border,
      borderTextFieldFocused:
          borderTextFieldFocused ?? this.borderTextFieldFocused,
      borderSubTitle: borderSubTitle ?? this.borderSubTitle,
      activeButton: activeButton ?? this.activeButton,
      disableButton: disableButton ?? this.disableButton,
      primaryBlue: primaryBlue ?? this.primaryBlue,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      active: ColorSwatch.lerp(active, other.active, t)!,
      red: ColorSwatch.lerp(red, other.red, t)!,
      blue: ColorSwatch.lerp(blue, other.blue, t)!,
      slate: ColorSwatch.lerp(slate, other.slate, t)!,
      green: ColorSwatch.lerp(green, other.green, t)!,
      orange: ColorSwatch.lerp(orange, other.orange, t)!,
      gray: ColorSwatch.lerp(gray, other.primaryA, t)!,
      yellow: ColorSwatch.lerp(yellow, other.yellow, t)!,
      amber: ColorSwatch.lerp(amber, other.amber, t)!,
      cyan: ColorSwatch.lerp(cyan, other.cyan, t)!,
      indigo: ColorSwatch.lerp(indigo, other.indigo, t)!,
      pink: ColorSwatch.lerp(pink, other.pink, t)!,
      violet: ColorSwatch.lerp(violet, other.violet, t)!,
      emerald: ColorSwatch.lerp(emerald, other.emerald, t)!,
      rose: ColorSwatch.lerp(rose, other.rose, t)!,
      primaryA: ColorSwatch.lerp(primaryA, other.primaryA, t)!,
      primaryB: ColorSwatch.lerp(primaryB, other.primaryB, t)!,
      primaryC: ColorSwatch.lerp(primaryC, other.primaryC, t)!,
      primaryCL: ColorSwatch.lerp(primaryCL, other.primaryCL, t)!,
      primaryD: ColorSwatch.lerp(primaryD, other.primaryD, t)!,
      black: ColorSwatch.lerp(black, other.black, t)!,
      white: ColorSwatch.lerp(white, other.white, t)!,
      semanticRed: ColorSwatch.lerp(semanticRed, other.semanticRed, t)!,
      semanticGreen: ColorSwatch.lerp(semanticGreen, other.semanticGreen, t)!,
      text: ColorSwatch.lerp(text, other.text, t)!,
      textDisabled: ColorSwatch.lerp(textDisabled, other.textDisabled, t)!,
      textBodyDefault: ColorSwatch.lerp(
        textBodyDefault,
        other.textBodyDefault,
        t,
      )!,
      textBodySub: ColorSwatch.lerp(textBodySub, other.textBodySub, t)!,
      textTitle: ColorSwatch.lerp(textTitle, other.textTitle, t)!,
      bodyActive: ColorSwatch.lerp(bodyActive, other.bodyActive, t)!,
      bodyLink: ColorSwatch.lerp(bodyLink, other.bodyLink, t)!,
      backgroundLightCyan: ColorSwatch.lerp(
        backgroundLightCyan,
        other.backgroundLightCyan,
        t,
      )!,
      border: ColorSwatch.lerp(border, other.border, t)!,
      borderTextFieldFocused: ColorSwatch.lerp(
        borderTextFieldFocused,
        other.borderTextFieldFocused,
        t,
      )!,
      borderSubTitle: ColorSwatch.lerp(
        borderSubTitle,
        other.borderSubTitle,
        t,
      )!,
      activeButton: ColorSwatch.lerp(activeButton, other.activeButton, t)!,
      disableButton: ColorSwatch.lerp(disableButton, other.disableButton, t)!,
      primaryBlue: ColorSwatch.lerp(primaryBlue, other.primaryBlue, t)!,
    );
  }
}
