import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_in_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_up_screen.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Routes
///
/// Defines the GoRouter routes for the authentication feature.
///
/// Each route wraps its screen in a [BlocProvider] that creates an [AuthCubit]
/// from the service locator (GetIt). This ensures:
///   • The cubit is scoped to the route lifecycle.
///   • The cubit is injected with all required use-cases via DI.
/// ──────────────────────────────────────────────────────────────────────────────
class AuthRoutes {
  static List<RouteBase> routes = [
    // ── Sign In ──
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const SignInScreen(),
      ),
    ),

    // ── Sign Up ──
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const SignUpScreen(),
      ),
    ),
  ];
}
