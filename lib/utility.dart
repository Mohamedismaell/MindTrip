import 'package:flutter/material.dart';

Widget addVertical(double height) {
  return SizedBox(height: height);
}

Widget addHorizental(double width) {
  return SizedBox(width: width);
}

extension ShortTheme on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}
