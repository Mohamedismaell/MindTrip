import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/app_flow.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/go_router_refresh_stream.dart';
import 'package:mindtrip/core/shared/routes/route_register.dart';
import 'package:mindtrip/features/authetication/routes/auth_routes.dart';
import 'package:mindtrip/features/home/routes/home_routes.dart';
import 'package:mindtrip/features/onboarding/routes/onboarding_routes.dart';

//Todo Add onBorading Route
class AppRouter {
  final AppGateCubit appGateCubit;
  AppRouter({required this.appGateCubit});

  late final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(appGateCubit.stream),
    redirect: _redirect,
    routes: [
      ...OnBoardingRoutes.routes,
      ...AuthRoutes.routes,
      ...HomeRoutes.routes,
      // ShellRoute(
      //   builder: (context, state, child) {
      //     return AppShell(location: state.uri.toString(), child: child);
      //   },
      //   routes: [
      //     StatefulShellRoute.indexedStack(
      //       builder: (context, state, navigationShell) {
      //         return TabsShell(navigationShell: navigationShell);
      //       },
      //       branches: [
      //         StatefulShellBranch(routes: [HomeRoutes.homeRoute]),
      //         StatefulShellBranch(routes: [ExploreRoutes.routes]),
      //         StatefulShellBranch(routes: [LibraryRoutes.bookmarksRoute]),
      //         StatefulShellBranch(routes: [ProfileRoutes.routes]),
      //       ],
      //     ),
      //     ...BookRoutes.routes,
      //     ExploreRoutes.extraRoute,
      //     // ...CategoriesRoutes.extraRoutes,
      //     // ...PostDetailsRoutes.routes,
      //   ],
      // ),
      // ...GeneraleRoutes.routes,
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final gateState = appGateCubit.state;
    final location = state.matchedLocation;

    final routeFlow = RouteRegister.getFlow(location);

    if (routeFlow == null) return null;

    if (gateState is AppGateLoading) {
      return routeFlow == AppFlow.splash ? null : AppRoutes.splash;
    }

    if (gateState is AppGateOnboarding) {
      return routeFlow == AppFlow.onboarding ? null : AppRoutes.onBoarding;
    }

    if (gateState is AppGateUnauthenticated) {
      return routeFlow == AppFlow.auth ? null : AppRoutes.welcomeAuth;
    }

    if (gateState is AppGateAuthenticated) {
      return routeFlow == AppFlow.app ? null : AppRoutes.home;
    }

    return null;
  }
}

//! Error Screen
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
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Something went wrong!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
