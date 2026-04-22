import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/map/presentation/screens/map_screen.dart';

class MapRoutes {
  static final mapRoute = GoRoute(
    path: AppRoutes.mapScreen,
    builder: (context, state) => const MapScreen(),
  );
}
