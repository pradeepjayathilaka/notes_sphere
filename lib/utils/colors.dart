import 'package:flutter/material.dart';

class AppColors {
  //primary colors
  static Color kBgColor = const Color(0xff202326);
  static const Color kFaBColor = Color.fromARGB(255, 204, 17, 237);
  static const Color kCardColor = Color(0xff2f3235);
  static const Color kWhiteColor = Colors.white;

  //gradient  colors
  static const int gradientStart = 0xff01f0ff;
  static const int gradientEnd = 0xff4441ed;

  LinearGradient kPrimaryGradient = const LinearGradient(
    colors: [
      Color(gradientStart),
      Color(gradientEnd),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
