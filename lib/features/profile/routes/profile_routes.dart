import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/fq_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/user_policy_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/terms_of_service_screen.dart';

class ProfileRoutes {
  static final profileRoute = GoRoute(
    path: AppRoutes.profile,
    builder: (context, state) => const ProfileScreen(),
  );
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.profileSettings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.profileTerms,
      builder: (context, state) => const TermsOfServiceScreen(),
    ),
    GoRoute(
      path: AppRoutes.profilePolicy,
      builder: (context, state) => const UserPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.profileFaq,
      builder: (context, state) => const FaqScreen(),
    ),
  ];
}
