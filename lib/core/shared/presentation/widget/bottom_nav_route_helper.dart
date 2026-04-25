import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';

class BottomNavRouteHelper {
  const BottomNavRouteHelper._();

  static const int homeIndex = 0;
  static const int favorites = 1;
  static const int explore = 2;
  static const int profileIndex = 3;

  // static int currentIndexForLocation(String location) {
  //   if (location.startsWith(AppRoutes.profile)) {
  //     return profileIndex;
  //   }
  //   if (location.startsWith(AppRoutes.explore)) {
  //     return explore;
  //   }
  //   return homeIndex;
  // }

  static void onTap(BuildContext context, int index) {
    switch (index) {
      case homeIndex:
        context.go(AppRoutes.home);
        return;
      case favorites:
        context.go(AppRoutes.favorites);
        return;
      case explore:
        context.go(AppRoutes.explore);
        return;
      case profileIndex:
        context.go(AppRoutes.profile);
        return;
      default:
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('This tab is coming soon.')),
          );
    }
  }
}
