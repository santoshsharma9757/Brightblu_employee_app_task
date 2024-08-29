import 'package:flutter/material.dart';

class AppScreenUtils {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeightPercentage(
      BuildContext context, double percentage) {
    return screenHeight(context) * percentage;
  }

  static double screenWidthPercentage(BuildContext context, double percentage) {
    return screenWidth(context) * percentage;
  }
}