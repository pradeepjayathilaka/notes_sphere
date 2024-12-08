import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';

class AppTextStyles {
  //title style
  static const TextStyle appTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.kWhiteColor,
  );
  //subtitle style
  static const TextStyle appsubTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.kWhiteColor,
  );
  //description large style
  static const TextStyle appDescriptionLargeStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.kWhiteColor,
  );
  //description samll style
  static const TextStyle appDescriptionSmallStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.kWhiteColor,
  );
  //appbody
  static const TextStyle appBody = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
  );
  //appbutton
  static const TextStyle appButton = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );
}
