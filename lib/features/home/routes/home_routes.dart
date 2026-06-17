import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/screens/home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';

class HomeRoutes {
  static final homeRoute = GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
        BlocProvider<RecommendedPlacesCubit>(
          create: (context) => sl<RecommendedPlacesCubit>(),
        ),
      ],
      child: const HomeScreen(),
    ),
  );
}
