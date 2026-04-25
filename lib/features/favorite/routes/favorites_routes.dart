import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/favorite/presentation/favorites_screen.dart';

class FavoritesRoutes {
  static final favoritesRoute = GoRoute(
    path: AppRoutes.favorites,
    builder: (context, state) => const FavoritesScreen(),
  );
}
