import 'package:flutter/material.dart';
import 'package:mindtrip/core/theme/app_colors.dart';

//! LIGHT SCHEME
final ColorScheme lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,

  // Primary action
  primary: AppColors.primaryBlue,
  onPrimary: AppColors.pureWhite,

  // Accent / highlight
  // secondary: AppColors.primaryLightBlue2,
  // onSecondary: AppColors.pureWhite,

  // Surfaces
  surface: AppColors.pureWhite,
  onSurface: AppColors.darkGray1,
  outline: AppColors.mediumLightGray,
  onSurfaceVariant: AppColors.darkGray2,
  // Status
  error: Colors.red,
  onError: AppColors.pureWhite,
);

//! DARK SCHEME
// final ColorScheme darkColorScheme = ColorScheme.dark(
//   brightness: Brightness.dark,

//   // Primary action
//   primary: AppSemanticColors.primaryActionDark,
//   onPrimary: AppSemanticColors.onPrimaryActionDark,

//   // Accent / highlight
//   secondary: AppSemanticColors.accentDark,
//   onSecondary: AppSemanticColors.textPrimaryDark,

//   // Surfaces
//   surface: AppSemanticColors.surfaceDark,
//   onSurface: AppSemanticColors.textPrimaryDark,
//   surfaceContainer: Color(0xFF9CA3AF).withAlpha(50),
//   // Status
//   error: Colors.red,
//   onError: AppSemanticColors.onPrimaryActionDark,
// );
