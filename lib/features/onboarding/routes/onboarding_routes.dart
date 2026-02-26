import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/interest_screen.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/onborading_screen.dart';
import 'package:mindtrip/features/onboarding/presentation/screens/splash_screen.dart';

class OnBoardingRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(create: (_) => sl<OnboardingCubit>(), child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.onBoarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.interests,
          builder: (context, state) => const InterestsScreen(),
        ),
      ],
    ),
  ];
}
