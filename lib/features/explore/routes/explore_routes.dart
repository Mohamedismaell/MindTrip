import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/explore/presentation/screens/explore_screen.dart';

class ExploreRoutes {
  static final exploreRoutes = GoRoute(
    path: AppRoutes.explore,
    builder: (context, state) => const ExploreScreen(),
  );
}
