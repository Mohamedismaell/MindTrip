import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';

class ProfileRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.profileSettings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ];
}
