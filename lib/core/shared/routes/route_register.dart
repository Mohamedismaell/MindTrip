import 'package:mindtrip/core/enums/app_flow.dart';
import 'package:mindtrip/core/shared/routes/app_route_config.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';

class RouteRegister {
  static const routes = [
    AppRouteConfig(path: AppRoutes.splash, flow: AppFlow.splash),

    // Onboarding flow
    AppRouteConfig(path: AppRoutes.onBoarding, flow: AppFlow.onboarding),
    AppRouteConfig(path: AppRoutes.interests, flow: AppFlow.interests),
    AppRouteConfig(path: AppRoutes.welcomeAuth, flow: AppFlow.onboarding),

    // Auth flow
    AppRouteConfig(path: AppRoutes.login, flow: AppFlow.auth),
    AppRouteConfig(path: AppRoutes.signup, flow: AppFlow.auth),
    AppRouteConfig(path: AppRoutes.forgetPassword, flow: AppFlow.auth),
    AppRouteConfig(path: AppRoutes.otpVerification, flow: AppFlow.auth),
    AppRouteConfig(path: AppRoutes.resetPassword, flow: AppFlow.auth),
    AppRouteConfig(path: AppRoutes.completeSignUpScreen, flow: AppFlow.auth),
    AppRouteConfig(
      path: AppRoutes.completeResetPasswordScreen,
      flow: AppFlow.auth,
    ),
    // Main app flow
    //! home
    AppRouteConfig(path: AppRoutes.home, flow: AppFlow.app),
    //! recommended
    AppRouteConfig(path: AppRoutes.recommendedPlaces, flow: AppFlow.app),
    //! search
    AppRouteConfig(path: AppRoutes.globalSearch, flow: AppFlow.app),
    //! favorites
    AppRouteConfig(path: AppRoutes.favorites, flow: AppFlow.app),
    //! explore
    AppRouteConfig(path: AppRoutes.explore, flow: AppFlow.app),
    //! ai planner
    AppRouteConfig(path: AppRoutes.aiPlannerIntro, flow: AppFlow.app),
    AppRouteConfig(path: AppRoutes.aiPlannerFlow, flow: AppFlow.app),
    AppRouteConfig(path: AppRoutes.aiPlannerChat, flow: AppFlow.app),
    //! profile
    AppRouteConfig(path: AppRoutes.profile, flow: AppFlow.app),
    AppRouteConfig(path: AppRoutes.editProfile, flow: AppFlow.app),
    AppRouteConfig(path: AppRoutes.profileSettings, flow: AppFlow.app),
    //! map
    AppRouteConfig(path: AppRoutes.map, flow: AppFlow.app),
    AppRouteConfig(path: AppRoutes.mapSearch, flow: AppFlow.app),
  ];

  static AppFlow? getFlow(String location) {
    try {
      return routes.firstWhere((r) => r.path == location).flow;
    } catch (_) {
      return null;
    }
  }
}
