import 'package:flutter/material.dart';

//primary colors
class AppColors {
  static Color kBgColor = const Color(0xff202326);
  static const Color kFabColor = Color.fromARGB(255, 204, 17, 237);
  static const Color kCardColor = Color(0xff2f3235);
  static const Color kWhiteColor = Colors.white;

  //gradient colors
  static const int gradientStart = 0xff01f0ff;
  static const int gradientEnd = 0xff4441ED;

  LinearGradient kPrimaryGradient = const LinearGradient(
    colors: [
      Color(gradientStart),
      Color(gradientEnd),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
