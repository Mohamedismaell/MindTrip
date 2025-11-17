import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/routes/splash_routes.dart';
import '../../features/authetication/routes/auth_routes.dart';
import 'app_routes.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true, // Set to false in production
    routes: [
      ...SplashRoutes.routes,
      ...AuthenticationRoutes.routes,
    ],

    // Optional: Add error handling
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error),

    // Optional: Add redirect logic
    // redirect: (context, state) {
    //   // Add your navigation logic here
    //   // For example, check if user is authenticated
    //   // if (!isAuthenticated && !_isPublicRoute(state.location)) {
    //   //   return AppRoutes.login;
    //   // }
    //   return null; // No redirect
    // },
  );

  //! Helper method to check if route is public
  // static bool _isPublicRoute(String location) {
  //   final publicRoutes = [
  //     AppRoutes.splash,
  //     AppRoutes.onBoarding1,
  //     AppRoutes.onBoarding2,
  //     AppRoutes.onBoarding3,
  //     AppRoutes.onBoarding4,
  //     AppRoutes.interests,
  //     AppRoutes.login,
  //     AppRoutes.register,
  //   ];
  //   return publicRoutes.contains(location);
  // }
}

// Error screen widget
class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
