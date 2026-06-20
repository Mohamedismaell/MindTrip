import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_bloc.dart';
import 'package:mindtrip/features/search/presentation/screens/global_search_screen.dart';

class SearchRoutes {
  SearchRoutes._();

  static List<RouteBase> get routes => [
        GoRoute(
          path: AppRoutes.globalSearch,
          builder: (context, state) {
            final heroTag = state.extra as String?;
            return BlocProvider(
              create: (context) => sl<GlobalSearchBloc>(),
              child: GlobalSearchScreen(
                heroTag: heroTag ?? 'home_search_bar_hero',
              ),
            );
          },
        ),
      ];
}
