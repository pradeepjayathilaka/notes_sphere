import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class Apphelpers {
  static void showSanackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFaBColor,
        content: Text(
          message,
          style: AppTextStyles.appButtonStyle,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
