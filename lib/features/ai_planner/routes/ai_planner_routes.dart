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
import 'package:mindtrip/features/itinerary/presentation/screens/trip_details_screen.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_share_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_chat_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_flow_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_intro_screen.dart';

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
            BlocProvider.value(value: sl<TripsCubit>()..loadTrips()),
            BlocProvider(create: (_) => sl<ChatCubit>()),
            BlocProvider(create: (_) => sl<TripDetailsCubit>()),
            BlocProvider(create: (_) => sl<TripShareCubit>()),
          ],
          child: child,
        );
      },
      routes: [
        AppTransitionRoute.fadeSlide(
          path: AppRoutes.myTrips,
          page: const MyTripsScreen(),
        ),
        GoRoute(
          path: AppRoutes.aiPlannerFlow,
          builder: (context, state) {
            final tripId = state.uri.queryParameters['tripId'];
            return AiPlannerFlowScreen(tripId: tripId);
          },
          routes: [
            AppTransitionRoute.slideBottom(
              path: 'chat',
              page: const AiPlannerChatScreen(),
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.tripCalendar,
          builder: (context, state) => const TripCalendarScreen(),
        ),
        //Todo should it be sub of my trips ?
        AppTransitionRoute.fadeSlideBuilder(
          path: AppRoutes.tripDetails,
          builder: (context, state) {
            final tripId = state.uri.queryParameters['tripId'] ?? '';
            context.read<TripDetailsCubit>().loadTripDetails(tripId);
            return TripDetailsScreen(tripId: tripId);
          },
        ),
      ],
    ),
  ];
}
