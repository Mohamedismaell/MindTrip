import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_chat_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_flow_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_intro_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/my_trips_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/trip_calendar_screen.dart';

class AiPlannerRoutes {
  static final aiPlannerRoute = GoRoute(
    path: AppRoutes.aiPlannerIntro,
    builder: (context, state) => const AiPlannerIntroScreen(),
  );

  static final aiPlannerFlowRoutes = [
    // TripsCubit lives at shell level so it's available across all sub-routes
    ShellRoute(
      builder: (context, state, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AiPlannerCubit>()),
            BlocProvider(create: (_) => sl<TripsCubit>()..loadTrips()),
            BlocProvider(create: (_) => sl<ChatCubit>()),
          ],
          child: child,
        );
      },
      routes: [
        // My Trips screen
        GoRoute(
          path: AppRoutes.myTrips,
          builder: (context, state) => const MyTripsScreen(),
        ),

        // Planner flow — accepts optional ?tripId= query param for resume
        GoRoute(
          path: AppRoutes.aiPlannerFlow,
          builder: (context, state) {
            final tripId = state.uri.queryParameters['tripId'];
            return AiPlannerFlowScreen(tripId: tripId);
          },
          routes: [
            GoRoute(
              path: 'chat',
              builder: (context, state) => const AiPlannerChatScreen(),
            ),
          ],
        ),

        // Trip Calendar
        GoRoute(
          path: AppRoutes.tripCalendar,
          builder: (context, state) => const TripCalendarScreen(),
        ),
      ],
    ),
  ];
}
