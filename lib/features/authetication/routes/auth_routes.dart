import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/authetication/presentation/screens/complete_reset_password.dart';
import 'package:mindtrip/features/authetication/presentation/screens/complete_signup_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/forget_password_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/otp_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/reset_password_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_in_screen.dart';
import 'package:mindtrip/features/authetication/presentation/screens/sign_up_screen.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    AppTransitionRoute.custom(
      path: AppRoutes.login,
      builder: (context, state) {
        return const SignInScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.signup,
      builder: (context, state) {
        return const SignUpScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.forgetPassword,
      builder: (context, state) {
        return const ForgetPasswordScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.otpVerification,
      builder: (context, state) {
        return const OtpScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.resetPassword,
      builder: (context, state) {
        return const ResetPasswordScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.completeSignUpScreen,
      builder: (context, state) {
        return const CompleteSignUpScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.completeResetPasswordScreen,
      builder: (context, state) {
        return const CompleteResetPassword();
      },
      transition: AppTransitionRoute.fade,
    ),
  ];
}
