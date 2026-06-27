import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/screens/my_trips_screen.dart';
import 'package:mindtrip/features/trips/presentation/screens/trip_calendar_screen.dart';
import 'package:mindtrip/features/trips/presentation/screens/trip_details_screen.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_chat_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_flow_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_intro_screen.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

class AiPlannerRoutes {
  static final aiPlannerRoute = GoRoute(
    path: AppRoutes.aiPlannerIntro,
    builder: (context, state) => const AiPlannerIntroScreen(),
  );

  static final aiPlannerFlowRoutes = [
    ShellRoute(
      builder: (context, state, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AiPlannerCubit>()),
            BlocProvider.value(value: sl<TripsCubit>()),
            BlocProvider(create: (_) => sl<ChatCubit>()),
            BlocProvider(create: (_) => sl<TripDetailsCubit>()),
          ],
          child: child,
        );
      },
      routes: [
        AppTransitionRoute.custom(
          path: AppRoutes.myTrips,
          builder: (context, state) {
            return const MyTripsScreen();
          },
          transition: AppTransitionRoute.fadeSlide,
        ),
        GoRoute(
          path: AppRoutes.aiPlannerFlow,
          builder: (context, state) {
            return AiPlannerFlowScreen();
          },
          routes: [
            AppTransitionRoute.custom(
              path: 'chat',
              builder: (context, state) {
                return AiPlannerChatScreen();
              },
              transition: AppTransitionRoute.slideBottom,
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.tripCalendar,
          builder: (context, state) => const TripCalendarScreen(),
        ),
        AppTransitionRoute.custom(
          path: AppRoutes.tripDetails,
          builder: (context, state) {
            final extra = state.extra;
            String? tripId;
            Trip? trip;

            if (extra is Trip) {
              trip = extra;
              tripId = trip.tripId;
            } else if (extra is String) {
              tripId = extra;
            } else {
              tripId = state.uri.queryParameters['tripId'];
            }

            return TripDetailsScreen(tripId: tripId!, trip: trip);
          },
          transition: AppTransitionRoute.fadeSlide,
        ),
      ],
    ),
  ];
}
