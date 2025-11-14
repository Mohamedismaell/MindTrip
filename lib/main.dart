import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/theme/theme_data/light_theme_data.dart';
import 'package:ttproj/features/templete/presentation/screens/splash_screens/interests_screen.dart';
import 'package:ttproj/features/templete/presentation/screens/splash_screens/sp1.dart';
import 'package:ttproj/features/templete/presentation/screens/splash_screens/sp2.dart';
import 'package:ttproj/features/templete/presentation/screens/splash_screens/sp3.dart';
import 'package:ttproj/features/templete/presentation/screens/splash_screens/sp4.dart';
import 'core/theme/theme_data/dark_theme_data.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initServiceLocator();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/sp1',
  routes: [
    GoRoute(
      path: '/sp1',
      builder: (context, state) => const Sp1(),
    ),
    GoRoute(
      path: '/sp2',
      builder: (context, state) => const Sp2(),
    ),
    GoRoute(
      path: '/sp3',
      builder: (context, state) => const Sp3(),
    ),
    GoRoute(
      path: '/sp4',
      builder: (context, state) => const Sp4(),
    ),
    GoRoute(
      path: '/interests',
      builder: (context, state) => InterestsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return;
      },
      title: 'Flutter Demo',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: ThemeMode.light,
      home: MaterialApp.router(routerConfig: _router),
    );
  }
}
