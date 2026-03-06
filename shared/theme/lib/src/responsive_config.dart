import 'package:flutter/material.dart';

class ResponsiveConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late bool isTable;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;

    screenHeight = size.height;
    screenWidth = size.width;

    // Material breakpoint for tablet;
    isTable = size.shortestSide >= 600;
  }

  static double width(double input) => (input / 360) * screenWidth;
  static double height(double input) => (input / 800) * screenHeight;
  static double scale(double fontSize) => (fontSize / 360) * screenWidth;
}

extension ResponsiveExtension on num {
  double get w => ResponsiveConfig.width(this.toDouble());
  double get h => ResponsiveConfig.height(this.toDouble());
  double get s => ResponsiveConfig.scale(this.toDouble());
}
