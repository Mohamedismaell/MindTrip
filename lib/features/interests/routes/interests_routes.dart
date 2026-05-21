import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/interests/presentation/screens/interests_screen.dart';

class InterestsRoutes {
  static List<RouteBase> routes = [
    AppTransitionRoute.fadeSlideBuilder(
      path: AppRoutes.interests,
      builder: (context, state) {
        final isEdit = state.extra as bool? ?? false;
        return InterestsScreen(isEdit: isEdit);
      },
    ),
  ];
}
