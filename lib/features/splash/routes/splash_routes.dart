import 'package:go_router/go_router.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/on_boarding/on_boarding1.dart';
import '../presentation/screens/on_boarding/on_boarding2.dart';
import '../presentation/screens/on_boarding/on_boarding3.dart';
import '../presentation/screens/on_boarding/on_boarding4.dart';
import '../presentation/screens/on_boarding/interests_screen.dart';
import '../../../core/routes/app_routes.dart';

class SplashRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding1,
      name: 'onboarding1',
      builder: (context, state) => const OnBoarding1(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding2,
      name: 'onboarding2',
      builder: (context, state) => const OnBoarding2(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding3,
      name: 'onboarding3',
      builder: (context, state) => const OnBoarding3(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding4,
      name: 'onboarding4',
      builder: (context, state) => const Sp4(),
    ),
    GoRoute(
      path: AppRoutes.interests,
      name: 'interests',
      builder: (context, state) => InterestsScreen(),
    ),
  ];
}
