import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/fq_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/user_policy_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/terms_of_service_screen.dart';

class ProfileRoutes {
  static final profileRoute = AppTransitionRoute.custom(
    path: AppRoutes.profile,
    builder: (context, state) {
      return const ProfileScreen();
    },
    transition: AppTransitionRoute.fade,
  );
  static List<RouteBase> routes = [
    AppTransitionRoute.custom(
      path: AppRoutes.editProfile,
      builder: (context, state) {
        return const EditProfileScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.profileSettings,
      builder: (context, state) {
        return const SettingsScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.profileTerms,
      builder: (context, state) {
        return const TermsOfServiceScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.profilePolicy,
      builder: (context, state) {
        return const UserPolicyScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.profileFaq,
      builder: (context, state) {
        return const FaqScreen();
      },
      transition: AppTransitionRoute.fade,
    ),
  ];
}
