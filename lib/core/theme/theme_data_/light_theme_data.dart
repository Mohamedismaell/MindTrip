import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_color_schemes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_theme.dart';

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

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 14.w),

      //* Default Border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),

      //* Enabled
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),

      //* Focused
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide(color: lightColorScheme.outline, width: 1.5),
      ),

      //* Error
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide(color: lightColorScheme.error),
      ),

      //* Focused Error
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide(color: lightColorScheme.error, width: 1.5),
      ),
    ),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: Colors.transparent,
    //     foregroundColor: AppColors.pureWhite,
    //     shadowColor: Colors.transparent,

    //     padding: EdgeInsets.symmetric(vertical: 12.h),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(25.r),
    //     ),
    //     // textStyle: AppTextStyles.headLine7Bold.copyWith(),
    //   ),
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.r, horizontal: 5.r),
        side: BorderSide(color: lightColorScheme.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        textStyle: responsiveTextTheme.labelMedium,
        alignment: Alignment.center,
        foregroundColor: lightColorScheme.primary,
      ),
    ),

    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(lightColorScheme.outline),
      thickness: WidgetStatePropertyAll(3),
      radius: const Radius.circular(100),
    ),
  );
}
