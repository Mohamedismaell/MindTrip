import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/home/presentation/screens/home_screen.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}
