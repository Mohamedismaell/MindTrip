import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_bloc.dart';
import 'package:mindtrip/features/search/presentation/cubit/voice_search_cubit.dart';
import 'package:mindtrip/features/search/presentation/screens/global_search_screen.dart';
import 'package:mindtrip/features/search/presentation/screens/voice_search_screen.dart';

class SearchRoutes {
  SearchRoutes._();

  static List<RouteBase> get routes => [
    // GoRoute(
    //   path: AppRoutes.globalSearch,
    //   builder: (context, state) {
    //     final heroTag = state.extra as String?;
    //     return BlocProvider(
    //       create: (context) => sl<GlobalSearchBloc>(),
    //       child: GlobalSearchScreen(heroTag: heroTag ?? 'home_search_bar_hero'),
    //     );
    //   },
    // ),
    AppTransitionRoute.custom(
      path: AppRoutes.globalSearch,

      builder: (context, state) {
        final heroTag = state.extra as String?;

        return BlocProvider(
          create: (_) => sl<GlobalSearchBloc>(),
          child: GlobalSearchScreen(heroTag: heroTag ?? 'home_search_bar_hero'),
        );
      },
      duration: const Duration(milliseconds: 600),
      transition: AppTransitionRoute.fade,
    ),
    AppTransitionRoute.custom(
      path: AppRoutes.voiceSearch,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<VoiceSearchCubit>(),
        child: const VoiceSearchScreen(),
      ),
      duration: const Duration(milliseconds: 600),

      transition: AppTransitionRoute.fade,
    ),
  ];
}
