import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';

class AppGradients {
  const AppGradients._();

  static LinearGradient mainBlueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primaryBlue.withValues(alpha: 17.0),
      AppColors.primaryLightBlue2,
    ],
  );
}
