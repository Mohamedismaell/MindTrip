import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

/// Navigation helper class to handle all navigation operations
class NavigationHelper {
  /// Navigate to splash screen
  static void goToSplash(BuildContext context) {
    context.go(AppRoutes.splash);
  }

  /// Navigate to onboarding screens
  static void goToOnBoarding1(BuildContext context) {
    context.go(AppRoutes.onBoarding1);
  }

  static void goToOnBoarding2(BuildContext context) {
    context.go(AppRoutes.onBoarding2);
  }

  static void goToOnBoarding3(BuildContext context) {
    context.go(AppRoutes.onBoarding3);
  }

  static void goToOnBoarding4(BuildContext context) {
    context.go(AppRoutes.onBoarding4);
  }

  static void goToInterests(BuildContext context) {
    context.go(AppRoutes.interests);
  }

  static void goToAuth(BuildContext context) {
    context.go(AppRoutes.mainAuth);
  }

  /// Navigate to authentication screens
  // static void goToLogin(BuildContext context) {
  //   context.go(AppRoutes.login);
  // }

  // static void goToRegister(BuildContext context) {
  //   context.go(AppRoutes.register);
  // }

  // static void goToForgotPassword(BuildContext context) {
  //   context.go(AppRoutes.forgotPassword);
  // }

  /// Navigate with replacement (won't allow back navigation)
  // static void goAndReplace(
  //   BuildContext context,
  //   String route,
  // ) {
  //   context.pushReplacement(route);
  // }

  // /// Navigate and clear all previous routes (like after login)
  // static void goAndClearStack(
  //   BuildContext context,
  //   String route,
  // ) {
  //   while (context.canPop()) {
  //     context.pop();
  //   }
  //   context.pushReplacement(route);
  // }

  //! Go back to previous screen
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  // /// Push a new screen on the stack
  // static void pushTo(BuildContext context, String route) {
  //   context.push(route);
  // }

  // /// Navigate with parameters
  // static void goWithParams(
  //   BuildContext context,
  //   String route,
  //   Map<String, String> params,
  // ) {
  //   final uri = Uri(path: route, queryParameters: params);
  //   context.go(uri.toString());
  // }

  // /// Push with parameters
  // static void pushWithParams(
  //   BuildContext context,
  //   String route,
  //   Map<String, String> params,
  // ) {
  //   final uri = Uri(path: route, queryParameters: params);
  //   context.push(uri.toString());
  // }
}
