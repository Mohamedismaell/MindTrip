import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/app_flow.dart';
import 'package:mindtrip/core/shared/presentation/shell/tabs_shell.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/presentation/shell/app_shell.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/go_router_refresh_stream.dart';
import 'package:mindtrip/core/shared/routes/route_register.dart';
import 'package:mindtrip/features/add_to_trip/routes/add_to_trip_routes.dart';
import 'package:mindtrip/features/ai_planner/routes/ai_planner_routes.dart';
import 'package:mindtrip/features/authetication/routes/auth_routes.dart';
import 'package:mindtrip/features/favorite/routes/favorites_routes.dart';
import 'package:mindtrip/features/home/routes/home_routes.dart';
import 'package:mindtrip/features/map/routes/map_routes.dart';
import 'package:mindtrip/features/interests/routes/interests_routes.dart';
import 'package:mindtrip/features/onboarding/routes/onboarding_routes.dart';
import 'package:mindtrip/features/explore/routes/explore_routes.dart';
import 'package:mindtrip/features/profile/routes/profile_routes.dart';
import 'package:mindtrip/features/place_details/routes/place_details_routes.dart';

class AppRouter {
  final AppGateCubit appGateCubit;
  AppRouter({required this.appGateCubit});

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(appGateCubit.stream),
    redirect: _redirect,
    routes: [
      ...OnBoardingRoutes.routes,
      ...AuthRoutes.routes,
      ...InterestsRoutes.routes,
      ...AddToTripRoutes.routes,
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return TabsShell(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(routes: [HomeRoutes.homeRoute]),
              StatefulShellBranch(routes: [FavoritesRoutes.favoritesRoute]),
              StatefulShellBranch(routes: [ExploreRoutes.exploreRoutes]),
              StatefulShellBranch(routes: [AiPlannerRoutes.aiPlannerRoute]),
              StatefulShellBranch(routes: [ProfileRoutes.profileRoute]),
            ],
          ),
          ...AiPlannerRoutes.aiPlannerFlowRoutes,
          ...ProfileRoutes.routes,
          ...MapRoutes.routes,
          ...PlaceDetailsRoutes.routes,

          // ...CategoriesRoutes.extraRoutes,
          // ...PostDetailsRoutes.routes,
        ],
      ),
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
      return routeFlow == AppFlow.auth || location == AppRoutes.welcomeAuth
          ? null
          : AppRoutes.login;
    }
    if (gateState is AppGateAuthenticated) {
      return routeFlow == AppFlow.app || routeFlow == AppFlow.interests
          ? null
          : AppRoutes.home;
    }

    if (gateState is AppGateInterestsRequired) {
      return routeFlow == AppFlow.interests ? null : AppRoutes.interests;
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
    return AppErrorWidget.route(onRetry: () => context.go(AppRoutes.home));
  }
}
