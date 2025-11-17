import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/theme_data/light_theme_data.dart';
import 'package:ttproj/core/routes/app_router.dart';
import 'core/theme/theme_data/dark_theme_data.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MindTrip',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}
