import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/screens/explore_screen.dart';

class ExploreRoutes {
  static final exploreRoutes = GoRoute(
    path: AppRoutes.explore,
    builder: (context, state) => BlocProvider(
      create: (context) => sl<ExploreCubit>()..loadAllData(),
      child: const ExploreScreen(),
    ),
  );
}
