import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  //! Solid Colors
  static const Color primaryBlue = Color(0xFF5596FE);
  static const Color primaryLightBlue1 = Color(0xFFC4E0F9);
  static const Color primaryLightBlue2 = Color(0xFF97CEFF);
  // static const Color primaryLightBlue2 = Color(0xFF97CDFF);
  static const Color primaryLightGray = Color(0xFFF3F4F6);
  static const Color mediumLightGray = Color(0xFF9CA3AF);
  static const Color darkGray1 = Color(0xFF374151);
  static const Color darkGray2 = Color(0xFF717171);
  static const Color pureBlack = Colors.black87;
  static const Color pureWhite = Colors.white;
  static const Color customYellow = Color(0xFFF8BD00);
  static const Color customLightBlue = Color(0xFFC4E0F9);
  static const Color customgreeen = Color(0xFF0BAB05);
  static const Color customgreeen2 = Color(0xFF76AE85);

  //! Shadow
  static const Color primaryShadow = Color(0xFFD9D9D9);

  //! Gradients
  static const LinearGradient blueLightGradient = LinearGradient(
    colors: [primaryBlue, primaryLightBlue2],
    begin: Alignment(0.00, 0.50),
    end: Alignment(1.00, 0.50),
  );

  static const LinearGradient lightBlueGradient = LinearGradient(
    colors: [primaryLightBlue2, pureWhite],
    begin: Alignment(0.50, -0.00),
    end: Alignment(0.50, 1.00),
  );

  //! addional
  //! Snackbar Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color successDarkGreen = Color(0xFF2D502D);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color errorRed = Color(0xFFE53935);
  static const Color errorDarkRed = Color(0xFF5C1F1F);
  static const Color errorLight = Color(0xFFFFEBEE);

  // Semantic aliases
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFF59E0B);
}
