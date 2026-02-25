import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(themeMode: ThemeMode.system));

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(ThemeState(themeMode: newMode));
  }

  final String _themeMode = 'themeMode';

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final savedMode = json[_themeMode] as String?;
    if (savedMode == 'system') {
      return ThemeState(themeMode: ThemeMode.system);
    } else if (savedMode == 'light') {
      return ThemeState(themeMode: ThemeMode.light);
    } else if (savedMode == 'dark') {
      return ThemeState(themeMode: ThemeMode.dark);
    }

    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ThemeState newMode) {
    if (newMode.themeMode == ThemeMode.system) {
      return {'themeMode': 'system'};
    } else if (newMode.themeMode == ThemeMode.light) {
      return {'themeMode': 'light'};
    } else if (newMode.themeMode == ThemeMode.dark) {
      return {'themeMode': 'dark'};
    }
    throw UnimplementedError();
  }
}
