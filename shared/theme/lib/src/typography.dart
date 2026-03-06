import 'package:flutter/painting.dart';

abstract class Typography {
  static const largeTitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    height: 40 / 34,
    letterSpacing: -1.02,
  );

  static const largeTitleEmphasized = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 40 / 34,
    letterSpacing: -1.02,
  );

  static const title1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 34 / 28,
    letterSpacing: -0.56,
  );

  static const title1Emphasized = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 34 / 28,
    letterSpacing: -0.56,
  );

  static const title2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 28 / 22,
    letterSpacing: -0.44,
  );

  static const title2Emphasized = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 28 / 22,
    letterSpacing: -0.40,
  );

  static const title3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 25 / 20,
    letterSpacing: -0.40,
  );

  static const title3Emphasized = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 25 / 20,
    letterSpacing: -0.40,
  );

  static const headline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 22 / 17,
    letterSpacing: -0.34,
  );

  static const body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 22 / 17,
    letterSpacing: -0.40,
  );

  static const bodyEmphasized = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 22 / 17,
    letterSpacing: -0.40,
  );

  static const callout = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 21 / 16,
    letterSpacing: -0.32,
  );

  static const calloutEmphasized = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 21 / 16,
    letterSpacing: -0.32,
  );

  static const subheadline = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 20 / 15,
    letterSpacing: -0.30,
  );

  static const subheadlineEmphasized = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 20 / 15,
    letterSpacing: -0.30,
  );

  static const footnote = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 18 / 13,
    letterSpacing: -0.40,
  );

  static const footnoteEmphasized = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 18 / 13,
    letterSpacing: -0.40,
  );

  static const caption1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: -0.40,
  );

  static const caption1Emphasized = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: -0.40,
  );

  static const caption2 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 13 / 11,
    letterSpacing: -0.40,
  );

  static const caption2Emphasized = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 13 / 11,
    letterSpacing: -0.40,
  );
}
