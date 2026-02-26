import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const String font = 'Merriweather';

  static TextTheme from(ColorScheme c) {
    return TextTheme(
      headlineLarge: AppTextStyles.h4SemiBold.copyWith(color: c.onSurface),
      headlineMedium: AppTextStyles.h5Medium.copyWith(color: c.onSurface),

      bodyLarge: AppTextStyles.h8Regular.copyWith(color: c.onSurface),

      labelLarge: AppTextStyles.h7Bold.copyWith(color: c.onPrimary),
    );
  }
}
