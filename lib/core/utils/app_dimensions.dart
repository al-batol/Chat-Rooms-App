import 'package:flutter/material.dart';

class ResponsiveLayout {
  static double getWidth(double width, BuildContext context) {
    final double screenWidth = ResponsiveLayout.screenWidth(context);
    const double baseWidth = 411.0;
    return width / screenWidth * baseWidth;
  }

  static double getHeight(double height, BuildContext context) {
    final double screenHeight = ResponsiveLayout.screenHeight(context);
    const double baseHeight = 853.0;
    return height / screenHeight * baseHeight;
  }

  static double getFontSize(double fontSize, BuildContext context) {
    final double screenWidth = ResponsiveLayout.screenWidth(context);
    return screenWidth / 100 * (fontSize / 3);
  }

  static double screenHeight(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return MediaQuery.of(context).size.height;
    } else if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width;
    }
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return MediaQuery.of(context).size.width;
    } else if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height;
    }
    return MediaQuery.of(context).size.width;
  }
}

// class Dimensions {
//   static double screenHeight(BuildContext context) =>
//       ResponsiveLayout.screenHeight(context);
//
//   static double screenWidth(BuildContext context) =>
//       ResponsiveLayout.screenWidth(context);
//
//   static double heightPercentage(BuildContext context, double percentage) =>
//       screenHeight(context) * percentage / 100;
//
//   static double widthPercentage(BuildContext context, double percentage) =>
//       screenWidth(context) * percentage / 100;
//
//   static double fontSize(BuildContext context, double percentage) =>
//       screenHeight(context) * percentage / 100;
//
//   static double radius(BuildContext context, double percentage) =>
//       screenHeight(context) * percentage / 100;
// }
