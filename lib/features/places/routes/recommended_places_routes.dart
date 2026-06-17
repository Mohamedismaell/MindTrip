import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';

import 'package:mindtrip/features/places/presentation/screen/recommended_places_screen.dart';

class RecommendedPlacesRoutes {
  static final recommendedRoute = [
    GoRoute(
      path: AppRoutes.recommendedPlaces,
      builder: (context, state) => BlocProvider<RecommendedPlacesCubit>(
        create: (context) => sl<RecommendedPlacesCubit>(),
        child: const RecommendedPlacesScreen(),
      ),
    ),
  ];
}
