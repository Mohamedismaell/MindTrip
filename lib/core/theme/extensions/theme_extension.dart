import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';

extension ThemeContextX on BuildContext {
  ThemeState get themeState => watch<ThemeCubit>().state;

  bool get isDark => themeState.isDark;
  bool get isLight => themeState.isLight;
}

extension ShortTheme on BuildContext {
  // ThemeData get themeContext => Theme.of(this);
  ColorScheme get colorTheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
