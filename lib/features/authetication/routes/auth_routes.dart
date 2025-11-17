import 'package:go_router/go_router.dart';
import '../presentation/screens/screens/authetication_screen.dart';
import '../../../core/routes/app_routes.dart';

class AuthenticationRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.mainAuth,
      name: 'authentication',
      builder: (context, state) =>
          const AutheticationScreen(),
    ),
    // Add more authentication routes here as you create them
    // GoRoute(
    //   path: AppRoutes.register,
    //   name: 'register',
    //   builder: (context, state) => const RegisterScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.forgotPassword,
    //   name: 'forgotPassword',
    //   builder: (context, state) => const ForgotPasswordScreen(),
    // ),
  ];
}
