import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';

ThemeData getLightTheme() {
  return ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 62.5,
          vertical: 12,
        ),
        foregroundColor: AppColors.pureWhite,
        textStyle: AppTextStyles.headLine7Regular
            .copyWith(),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 62.5,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        foregroundColor: AppColors.pureWhite,
        textStyle: AppTextStyles.headLine7Bold.copyWith(),
      ),
    ),
  );
}
