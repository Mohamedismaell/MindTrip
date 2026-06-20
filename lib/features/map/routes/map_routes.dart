import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/map/data/models/map_trip_extra.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/bloc/map_search_bloc.dart';
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
            BlocProvider(create: (context) => sl<MapSearchBloc>()),
            BlocProvider(create: (context) => sl<MapNavigationCubit>()),
          ],
          child: child,
        );
      },
      routes: [
        AppTransitionRoute.custom(
          path: AppRoutes.map,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is MapTripExtra) {
              return MapScreen(tripExtra: extra);
            } else if (extra is List<PlaceEntity>) {
              return MapScreen(places: extra);
            } else if (extra is PlaceEntity) {
              return MapScreen(place: extra);
            } else {
              return const MapScreen();
            }
          },
          transition: AppTransitionRoute.fadeSlide,
          routes: [
            AppTransitionRoute.custom(
              path: "search",
              builder: (_, _) => const MapSearchOverlay(),
              transition: AppTransitionRoute.slideTop,
            ),
          ],
        ),
      ],
    ),
  ];
}
