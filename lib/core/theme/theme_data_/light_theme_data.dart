import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttproj/core/theme/app_color_schemes.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/core/theme/app_text_theme.dart';

ThemeData getLightTheme() {
  final rawTextTheme = AppTextTheme.from(lightColorScheme);
  final responsiveTextTheme = rawTextTheme.apply(fontSizeFactor: 1.sp);
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: responsiveTextTheme,
    scaffoldBackgroundColor: AppColors.pureWhite,

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 62.5.w, vertical: 12.h),
        foregroundColor: AppColors.pureWhite,
        // textStyle: AppTextStyles.headLine7Regular.copyWith(),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 62.5, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: AppColors.pureWhite,
        // textStyle: AppTextStyles.headLine7Bold.copyWith(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.mediumLightGray, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 62.5, vertical: 12),
        foregroundColor: AppColors.darkGray1,
        // textStyle: AppTextStyles.headLine7Regular.copyWith(),
      ),
    ),
  );
}
