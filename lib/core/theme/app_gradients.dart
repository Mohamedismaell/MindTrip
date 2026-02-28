import 'package:flutter/material.dart';
import 'package:mindtrip/core/theme/app_colors.dart';

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
  static LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.center,
    colors: [
      AppColors.primaryLightBlue2,
      Color(0xFFEDEDED),
      AppColors.pureWhite,
    ],
  );
}
