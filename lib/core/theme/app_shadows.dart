import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow mainElevationButton = BoxShadow(
    color: Colors.black.withValues(alpha: 0.25),
    blurRadius: 10,
    offset: Offset(0, 3),
    spreadRadius: 0,
  );
  static BoxShadow tourPackagesCard = BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 4,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );
  // static BoxShadow trendingCard = BoxShadow(
  //   color: Colors.black.withValues(alpha: 0.08),
  //   blurRadius: 4,
  //   offset: Offset(0, 4),
  //   spreadRadius: 0,
  // );
  static BoxShadow floatMapButton = BoxShadow(
    blurRadius: 10,
    offset: Offset(0, 5),
    color: Colors.black.withValues(alpha: 0.25),
  );
}
