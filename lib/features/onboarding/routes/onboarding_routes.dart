import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/shared/injection/service_locator.dart';
import 'package:ttproj/core/shared/routes/app_routes.dart';
import 'package:ttproj/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:ttproj/features/onboarding/presentation/screens/onborading_screen.dart';
import 'package:ttproj/features/onboarding/presentation/screens/splash_screen.dart';

class OnBoardingRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => BlocProvider<OnboardingCubit>(
        create: (context) => sl<OnboardingCubit>(),
        child: const OnboardingScreen(),
      ),
    ),
  ];
}
