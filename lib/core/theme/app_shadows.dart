import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow mainElevationButton = BoxShadow(
    color: Colors.black.withValues(alpha: 0.25),
    blurRadius: 10.r,
    offset: Offset(0, 3.h),
    spreadRadius: 0,
  );
  static BoxShadow tourPackagesCard = BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 4.r,
    offset: Offset(0, 4.h),
    spreadRadius: 0,
  );
  // static BoxShadow trendingCard = BoxShadow(
  //   color: Colors.black.withValues(alpha: 0.08),
  //   blurRadius: 4,
  //   offset: Offset(0, 4),
  //   spreadRadius: 0,
  // );
  static BoxShadow floatMapButton = BoxShadow(
    blurRadius: 10.r,
    offset: Offset(0, 5.h),
    color: Colors.black.withValues(alpha: 0.25),
  );
  static BoxShadow aiplannerShadow = BoxShadow(
    blurRadius: 4.r,
    offset: Offset(0, 2.h),
    color: Colors.black.withValues(alpha: 0.25),
  );
  static BoxShadow budgetCardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    blurRadius: 8.r,
    offset: Offset(0, 2.h),
  );
}
