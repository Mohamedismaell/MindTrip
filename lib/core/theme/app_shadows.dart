import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow mainElevationButton = BoxShadow(
    color: Colors.black.withValues(alpha: 0.25),
    blurRadius: 10,
    offset: Offset(0, 3),
    spreadRadius: 0,
  );
}
