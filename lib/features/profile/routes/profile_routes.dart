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
  static final profileRoute = AppTransitionRoute.fadeSlide(
    path: AppRoutes.profile,
    page: const ProfileScreen(),
  );
  static List<RouteBase> routes = [
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.editProfile,
      page: const EditProfileScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.profileSettings,
      page: const SettingsScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.profileTerms,
      page: const TermsOfServiceScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.profilePolicy,
      page: const UserPolicyScreen(),
    ),
    AppTransitionRoute.fadeSlide(
      path: AppRoutes.profileFaq,
      page: const FaqScreen(),
    ),
  ];
}
