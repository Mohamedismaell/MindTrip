import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_search_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/screens/map_screen.dart';
import 'package:mindtrip/features/map/presentation/screens/map_search_overlay.dart';

class MapRoutes {
  static final routes = [
    ShellRoute(
      builder: (context, state, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<MapCubit>()),
            BlocProvider(create: (context) => sl<MapSearchCubit>()),
            BlocProvider(create: (context) => sl<MapNavigationCubit>()),
          ],
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.map,
          builder: (context, state) => const MapScreen(),
          routes: [
            GoRoute(
              path: "search",
              builder: (context, state) => const MapSearchOverlay(),
            ),
          ],
        ),
      ],
    ),
  ];
}
