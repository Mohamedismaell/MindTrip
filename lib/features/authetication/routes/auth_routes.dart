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
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.login,
      page: const SignInScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.signup,
      page: const SignUpScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.forgetPassword,
      page: const ForgetPasswordScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.otpVerification,
      page: const OtpScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.resetPassword,
      page: const ResetPasswordScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.completeSignUpScreen,
      page: const CompleteSignUpScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.completeResetPasswordScreen,
      page: const CompleteResetPassword(),
    ),
  ];
}
