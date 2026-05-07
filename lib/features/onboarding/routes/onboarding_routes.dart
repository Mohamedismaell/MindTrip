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
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.splash,
      page: const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(create: (_) => sl<OnboardingCubit>(), child: child);
      },
      routes: [
        AppTransitionRoute.fadeSlide(
          path: AppRoutes.onBoarding,
          page: const OnboardingScreen(),
        ),

        AppTransitionRoute.fadeSlide(
          path: AppRoutes.welcomeAuth,
          page: const WelcomeAuthScreen(),
        ),
      ],
    ),
  ];
}
