import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_font_family_old.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle _headline({
    required double size,
    required FontWeight weight,
    Color? color,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    fontFamily: AppFontFamily.sfPro,
    color: color,
  );

  //! Headline 1
  static final h1Bold = _headline(size: 60, weight: FontWeight.bold);
  static final h1SemiBold = _headline(size: 60, weight: FontWeight.w600);
  static final h1Medium = _headline(size: 60, weight: FontWeight.w500);
  static final h1Regular = _headline(size: 60, weight: FontWeight.w400);
  static final h1Light = _headline(size: 60, weight: FontWeight.w300);

  //! Headline 2
  static final h2Bold = _headline(size: 48, weight: FontWeight.bold);
  static final h2SemiBold = _headline(size: 48, weight: FontWeight.w600);
  static final h2Medium = _headline(size: 48, weight: FontWeight.w500);
  static final h2Regular = _headline(size: 48, weight: FontWeight.w400);
  static final h2Light = _headline(size: 48, weight: FontWeight.w300);

  //! Headline 3
  static final h3Bold = _headline(size: 40, weight: FontWeight.bold);
  static final h3SemiBold = _headline(size: 40, weight: FontWeight.w600);
  static final h3Medium = _headline(size: 40, weight: FontWeight.w500);
  static final h3Regular = _headline(size: 40, weight: FontWeight.w400);
  static final h3Light = _headline(size: 40, weight: FontWeight.w300);

  //! Headline 4
  static final h4Bold = _headline(size: 36, weight: FontWeight.bold);
  static final h4SemiBold = _headline(size: 36, weight: FontWeight.w600);
  static final h4Medium = _headline(size: 36, weight: FontWeight.w500);
  static final h4Regular = _headline(size: 36, weight: FontWeight.w400);
  static final h4Light = _headline(size: 36, weight: FontWeight.w300);

  //! Headline 5
  static final h5Bold = _headline(size: 28, weight: FontWeight.bold);
  static final h5SemiBold = _headline(size: 28, weight: FontWeight.w600);
  static final h5Medium = _headline(size: 28, weight: FontWeight.w500);
  static final h5Regular = _headline(size: 28, weight: FontWeight.w400);
  static final h5Light = _headline(size: 28, weight: FontWeight.w300);

  //! Headline 6
  static final h6Bold = _headline(size: 24, weight: FontWeight.bold);
  static final h6SemiBold = _headline(size: 24, weight: FontWeight.w600);
  static final h6Medium = _headline(size: 24, weight: FontWeight.w500);
  static final h6Regular = _headline(size: 24, weight: FontWeight.w400);
  static final h6Light = _headline(size: 24, weight: FontWeight.w300);

  //! Headline 7
  static final h7Bold = _headline(size: 20, weight: FontWeight.bold);
  static final h7SemiBold = _headline(size: 20, weight: FontWeight.w600);
  static final h7Medium = _headline(size: 20, weight: FontWeight.w500);
  static final h7Regular = _headline(size: 20, weight: FontWeight.w400);
  static final h7Light = _headline(size: 20, weight: FontWeight.w300);

  //! Headline 8
  static final h8Bold = _headline(size: 18, weight: FontWeight.bold);
  static final h8SemiBold = _headline(size: 18, weight: FontWeight.w600);
  static final h8Medium = _headline(size: 18, weight: FontWeight.w500);
  static final h8Regular = _headline(size: 18, weight: FontWeight.w400);
  static final h8Light = _headline(size: 18, weight: FontWeight.w300);

  //! Headline 9
  static final h9Bold = _headline(size: 16, weight: FontWeight.bold);
  static final h9SemiBold = _headline(size: 16, weight: FontWeight.w600);
  static final h9Medium = _headline(size: 16, weight: FontWeight.w500);
  static final h9Regular = _headline(size: 16, weight: FontWeight.w400);
  static final h9Light = _headline(size: 16, weight: FontWeight.w300);
}
