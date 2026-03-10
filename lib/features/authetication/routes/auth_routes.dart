import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_in_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_up_screen.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const SignInScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const SignUpScreen(),
      ),
    ),
  ];
}
