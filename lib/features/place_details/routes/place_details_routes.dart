import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/screens/place_details_screen.dart';

class PlaceDetailsRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: AppRoutes.placeDetails,
      builder: (context, state) {
        final placeId = state.uri.queryParameters['placeId'];
        if (placeId == null) {
          throw Exception('placeId is required for place details route');
        }
        final heroTag = state.uri.queryParameters['heroTag'];

        final preview = state.extra as PlaceEntity?;

        return BlocProvider(
          create: (_) => sl<PlaceDetailsCubit>()
            ..loadPlaceDetails(placeId, preview: preview)
            ..loadNearbyPlaces(
              placeId,
              lat: preview?.location.latitude,
              lng: preview?.location.longitude,
            ),
          child: PlaceDetailsScreen(heroTag: heroTag),
        );
      },
    ),
  ];
}
