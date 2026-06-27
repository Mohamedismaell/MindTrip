import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/onborading_screen.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/welcome_auth_screen.dart';

class OnBoardingRoutes {
  static List<RouteBase> routes = [
    AppTransitionRoute.custom(
      path: AppRoutes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(create: (_) => sl<OnboardingCubit>(), child: child);
      },
      routes: [
        AppTransitionRoute.custom(
          path: AppRoutes.onBoarding,
          builder: (context, state) {
            return const OnboardingScreen();
          },
          transition: AppTransitionRoute.fade,
        ),

        AppTransitionRoute.custom(
          path: AppRoutes.welcomeAuth,
          builder: (context, state) {
            return const WelcomeAuthScreen();
          },
          transition: AppTransitionRoute.fade,
        ),
      ],
    ),
  ];
}
