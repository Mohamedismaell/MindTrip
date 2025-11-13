import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  //! Solid Colors
  static const Color primaryBlue = Color(0xFF5596FE);
  static const Color primaryLightBlue1 = Color(0xFFC4E0F9);
  static const Color primaryLightBlue2 = Color(0xFF97CDFF);
  static const Color primaryLightGray = Color(0xFFF3F4F6);
  static const Color mediumLightGray = Color(0xFF9CA3AF);
  static const Color darkGray1 = Color(0xFF374151);
  static const Color darkGray2 = Color(0xFF717171);
  static const Color pureBlack = Colors.black;
  static const Color pureWhite = Colors.white;

  //! Shadow
  static const Color primaryShadow = Color(0xFFD9D9D9);
  //! Gradients
  static const LinearGradient blueLightGradient =
      LinearGradient(
        colors: [primaryBlue, primaryLightBlue2],
        begin: Alignment(0.00, 0.50),
        end: Alignment(1.00, 0.50),
      );

  static const LinearGradient lightBlueGradient =
      LinearGradient(
        colors: [primaryLightBlue2, pureWhite],
        begin: Alignment(0.50, -0.00),
        end: Alignment(0.50, 1.00),
      );
}
