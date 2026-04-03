import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/authetication/presentation/screens/forget_password_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/otp_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/reset_password_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_in_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_up_screen.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const SignInScreen(),
    ),

    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgetPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.otpVerification,
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
  ];
}
