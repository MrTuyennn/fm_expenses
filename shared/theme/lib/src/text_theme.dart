import 'package:flutter/material.dart';

import 'typography.dart' as typography;
import 'typography.tablet.dart' as table_typography;

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  AppTextTheme._({
    required this.largeTitle,
    required this.largeTitleEmphasized,
    required this.title1,
    required this.title1Emphasized,
    required this.title2,
    required this.title2Emphasized,
    required this.title3,
    required this.title3Emphasized,
    required this.headline,
    required this.body,
    required this.bodyEmphasized,
    required this.callout,
    required this.calloutEmphasized,
    required this.subheadline,
    required this.subheadlineEmphasized,
    required this.footnote,
    required this.footnoteEmphasized,
    required this.caption1,
    required this.caption1Emphasized,
    required this.caption2,
    required this.caption2Emphasized,
  });

  factory AppTextTheme.light() {
    return AppTextTheme._(
      largeTitle: typography.Typography.largeTitle.copyWith(
        color: Colors.black,
      ),
      largeTitleEmphasized: typography.Typography.largeTitleEmphasized.copyWith(
        color: Colors.black,
      ),
      title1: typography.Typography.title1.copyWith(color: Colors.black),
      title1Emphasized: typography.Typography.title1Emphasized.copyWith(
        color: Colors.black,
      ),
      title2: typography.Typography.title2.copyWith(color: Colors.black),
      title2Emphasized: typography.Typography.title2Emphasized.copyWith(
        color: Colors.black,
      ),
      title3: typography.Typography.title2.copyWith(color: Colors.black),
      title3Emphasized: typography.Typography.title3Emphasized.copyWith(
        color: Colors.black,
      ),
      headline: typography.Typography.headline.copyWith(color: Colors.black),
      body: typography.Typography.body.copyWith(color: Colors.black),
      bodyEmphasized: typography.Typography.bodyEmphasized.copyWith(
        color: Colors.black,
      ),
      callout: typography.Typography.callout.copyWith(color: Colors.black),
      calloutEmphasized: typography.Typography.calloutEmphasized.copyWith(
        color: Colors.black,
      ),
      subheadline: typography.Typography.subheadline.copyWith(
        color: Colors.black,
      ),
      subheadlineEmphasized: typography.Typography.subheadlineEmphasized
          .copyWith(color: Colors.black),
      footnote: typography.Typography.footnote.copyWith(color: Colors.black),
      footnoteEmphasized: typography.Typography.footnoteEmphasized.copyWith(
        color: Colors.black,
      ),
      caption1: typography.Typography.caption1.copyWith(color: Colors.black),
      caption1Emphasized: typography.Typography.caption1Emphasized.copyWith(
        color: Colors.black,
      ),
      caption2: typography.Typography.caption2.copyWith(color: Colors.black),
      caption2Emphasized: typography.Typography.caption2Emphasized.copyWith(
        color: Colors.black,
      ),
    );
  }

  factory AppTextTheme.dark() {
    return AppTextTheme._(
      largeTitle: typography.Typography.largeTitle.copyWith(
        color: Colors.white,
      ),
      largeTitleEmphasized: typography.Typography.largeTitleEmphasized.copyWith(
        color: Colors.white,
      ),
      title1: typography.Typography.title1.copyWith(color: Colors.white),
      title1Emphasized: typography.Typography.title1Emphasized.copyWith(
        color: Colors.white,
      ),
      title2: typography.Typography.title2.copyWith(color: Colors.white),
      title2Emphasized: typography.Typography.title2Emphasized.copyWith(
        color: Colors.white,
      ),
      title3: typography.Typography.title2.copyWith(color: Colors.white),
      title3Emphasized: typography.Typography.title3Emphasized.copyWith(
        color: Colors.white,
      ),
      headline: typography.Typography.headline.copyWith(color: Colors.white),
      body: typography.Typography.body.copyWith(color: Colors.white),
      bodyEmphasized: typography.Typography.bodyEmphasized.copyWith(
        color: Colors.white,
      ),
      callout: typography.Typography.callout.copyWith(color: Colors.white),
      calloutEmphasized: typography.Typography.calloutEmphasized.copyWith(
        color: Colors.white,
      ),
      subheadline: typography.Typography.subheadline.copyWith(
        color: Colors.white,
      ),
      subheadlineEmphasized: typography.Typography.subheadlineEmphasized
          .copyWith(color: Colors.white),
      footnote: typography.Typography.footnote.copyWith(color: Colors.white),
      footnoteEmphasized: typography.Typography.footnoteEmphasized.copyWith(
        color: Colors.white,
      ),
      caption1: typography.Typography.caption1.copyWith(color: Colors.white),
      caption1Emphasized: typography.Typography.caption1Emphasized.copyWith(
        color: Colors.white,
      ),
      caption2: typography.Typography.caption2.copyWith(color: Colors.white),
      caption2Emphasized: typography.Typography.caption2Emphasized.copyWith(
        color: Colors.white,
      ),
    );
  }

  factory AppTextTheme.lightTablet() {
    return AppTextTheme._(
      largeTitle: table_typography.Typography.largeTitle.copyWith(
        color: Colors.black,
      ),
      largeTitleEmphasized: table_typography.Typography.largeTitleEmphasized
          .copyWith(color: Colors.black),
      title1: table_typography.Typography.title1.copyWith(color: Colors.black),
      title1Emphasized: table_typography.Typography.title1Emphasized.copyWith(
        color: Colors.black,
      ),
      title2: table_typography.Typography.title2.copyWith(color: Colors.black),
      title2Emphasized: table_typography.Typography.title2Emphasized.copyWith(
        color: Colors.black,
      ),
      title3: table_typography.Typography.title2.copyWith(color: Colors.black),
      title3Emphasized: table_typography.Typography.title3Emphasized.copyWith(
        color: Colors.black,
      ),
      headline: table_typography.Typography.headline.copyWith(
        color: Colors.black,
      ),
      body: table_typography.Typography.body.copyWith(color: Colors.black),
      bodyEmphasized: table_typography.Typography.bodyEmphasized.copyWith(
        color: Colors.black,
      ),
      callout: table_typography.Typography.callout.copyWith(
        color: Colors.black,
      ),
      calloutEmphasized: table_typography.Typography.calloutEmphasized.copyWith(
        color: Colors.black,
      ),
      subheadline: table_typography.Typography.subheadline.copyWith(
        color: Colors.black,
      ),
      subheadlineEmphasized: table_typography.Typography.subheadlineEmphasized
          .copyWith(color: Colors.black),
      footnote: table_typography.Typography.footnote.copyWith(
        color: Colors.black,
      ),
      footnoteEmphasized: table_typography.Typography.footnoteEmphasized
          .copyWith(color: Colors.black),
      caption1: table_typography.Typography.caption1.copyWith(
        color: Colors.black,
      ),
      caption1Emphasized: table_typography.Typography.caption1Emphasized
          .copyWith(color: Colors.black),
      caption2: table_typography.Typography.caption2.copyWith(
        color: Colors.black,
      ),
      caption2Emphasized: table_typography.Typography.caption2Emphasized
          .copyWith(color: Colors.black),
    );
  }

  factory AppTextTheme.darkTablet() {
    return AppTextTheme._(
      largeTitle: table_typography.Typography.largeTitle.copyWith(
        color: Colors.white,
      ),
      largeTitleEmphasized: table_typography.Typography.largeTitleEmphasized
          .copyWith(color: Colors.white),
      title1: table_typography.Typography.title1.copyWith(color: Colors.white),
      title1Emphasized: table_typography.Typography.title1Emphasized.copyWith(
        color: Colors.white,
      ),
      title2: table_typography.Typography.title2.copyWith(color: Colors.white),
      title2Emphasized: table_typography.Typography.title2Emphasized.copyWith(
        color: Colors.white,
      ),
      title3: table_typography.Typography.title2.copyWith(color: Colors.white),
      title3Emphasized: table_typography.Typography.title3Emphasized.copyWith(
        color: Colors.white,
      ),
      headline: table_typography.Typography.headline.copyWith(
        color: Colors.white,
      ),
      body: table_typography.Typography.body.copyWith(color: Colors.white),
      bodyEmphasized: table_typography.Typography.bodyEmphasized.copyWith(
        color: Colors.white,
      ),
      callout: table_typography.Typography.callout.copyWith(
        color: Colors.white,
      ),
      calloutEmphasized: table_typography.Typography.calloutEmphasized.copyWith(
        color: Colors.white,
      ),
      subheadline: table_typography.Typography.subheadline.copyWith(
        color: Colors.white,
      ),
      subheadlineEmphasized: table_typography.Typography.subheadlineEmphasized
          .copyWith(color: Colors.white),
      footnote: table_typography.Typography.footnote.copyWith(
        color: Colors.white,
      ),
      footnoteEmphasized: table_typography.Typography.footnoteEmphasized
          .copyWith(color: Colors.white),
      caption1: table_typography.Typography.caption1.copyWith(
        color: Colors.white,
      ),
      caption1Emphasized: table_typography.Typography.caption1Emphasized
          .copyWith(color: Colors.white),
      caption2: table_typography.Typography.caption2.copyWith(
        color: Colors.white,
      ),
      caption2Emphasized: table_typography.Typography.caption2Emphasized
          .copyWith(color: Colors.white),
    );
  }

  final TextStyle largeTitle;
  final TextStyle largeTitleEmphasized;
  final TextStyle title1;
  final TextStyle title1Emphasized;
  final TextStyle title2;
  final TextStyle title2Emphasized;
  final TextStyle title3;
  final TextStyle title3Emphasized;
  final TextStyle headline;
  final TextStyle body;
  final TextStyle bodyEmphasized;
  final TextStyle callout;
  final TextStyle calloutEmphasized;
  final TextStyle subheadline;
  final TextStyle subheadlineEmphasized;
  final TextStyle footnote;
  final TextStyle footnoteEmphasized;
  final TextStyle caption1;
  final TextStyle caption1Emphasized;
  final TextStyle caption2;
  final TextStyle caption2Emphasized;

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? largeTitle,
    TextStyle? largeTitleEmphasized,
    TextStyle? title1,
    TextStyle? title1Emphasized,
    TextStyle? title2,
    TextStyle? title2Emphasized,
    TextStyle? title3,
    TextStyle? title3Emphasized,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? bodyEmphasized,
    TextStyle? callout,
    TextStyle? calloutEmphasized,
    TextStyle? subheadline,
    TextStyle? subheadlineEmphasized,
    TextStyle? footnote,
    TextStyle? footnoteEmphasized,
    TextStyle? caption1,
    TextStyle? caption1Emphasized,
    TextStyle? caption2,
    TextStyle? caption2Emphasized,
    TextStyle? primaryButtonTitle,
  }) {
    return AppTextTheme._(
      largeTitle: largeTitle ?? this.largeTitle,
      largeTitleEmphasized: largeTitleEmphasized ?? this.largeTitleEmphasized,
      title1: title1 ?? this.title1,
      title1Emphasized: title1Emphasized ?? this.title1Emphasized,
      title2: title2 ?? this.title2,
      title2Emphasized: title2Emphasized ?? this.title2Emphasized,
      title3: title3 ?? this.title3,
      title3Emphasized: title3Emphasized ?? this.title3Emphasized,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      bodyEmphasized: bodyEmphasized ?? this.bodyEmphasized,
      callout: callout ?? this.callout,
      calloutEmphasized: calloutEmphasized ?? this.calloutEmphasized,
      subheadline: subheadline ?? this.subheadline,
      subheadlineEmphasized:
          subheadlineEmphasized ?? this.subheadlineEmphasized,
      footnote: footnote ?? this.footnote,
      footnoteEmphasized: footnoteEmphasized ?? this.footnoteEmphasized,
      caption1: caption1 ?? this.caption1,
      caption1Emphasized: caption1Emphasized ?? this.caption1Emphasized,
      caption2: caption2 ?? this.caption2,
      caption2Emphasized: caption2Emphasized ?? this.caption2Emphasized,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
    covariant ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t)!,
      largeTitleEmphasized: TextStyle.lerp(
        largeTitleEmphasized,
        other.largeTitleEmphasized,
        t,
      )!,
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title1Emphasized: TextStyle.lerp(
        title1Emphasized,
        other.title1Emphasized,
        t,
      )!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      title2Emphasized: TextStyle.lerp(
        title2Emphasized,
        other.title2Emphasized,
        t,
      )!,
      title3: TextStyle.lerp(title3, other.title3, t)!,
      title3Emphasized: TextStyle.lerp(
        title3Emphasized,
        other.title3Emphasized,
        t,
      )!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodyEmphasized: TextStyle.lerp(bodyEmphasized, other.bodyEmphasized, t)!,
      callout: TextStyle.lerp(callout, other.callout, t)!,
      calloutEmphasized: TextStyle.lerp(
        calloutEmphasized,
        other.calloutEmphasized,
        t,
      )!,
      subheadline: TextStyle.lerp(subheadline, other.subheadline, t)!,
      subheadlineEmphasized: TextStyle.lerp(
        subheadlineEmphasized,
        other.subheadlineEmphasized,
        t,
      )!,
      footnote: TextStyle.lerp(footnote, other.footnote, t)!,
      footnoteEmphasized: TextStyle.lerp(
        footnoteEmphasized,
        other.footnoteEmphasized,
        t,
      )!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption1Emphasized: TextStyle.lerp(
        caption1Emphasized,
        other.caption1Emphasized,
        t,
      )!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
      caption2Emphasized: TextStyle.lerp(
        caption2Emphasized,
        other.caption2Emphasized,
        t,
      )!,
    );
  }
}
