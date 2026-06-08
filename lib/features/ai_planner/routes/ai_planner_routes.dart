import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/add_to_trip_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/manage_place_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/select_day_sheet.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/screens/trips_screen.dart';
import 'package:mindtrip/features/trips/presentation/screens/trip_calendar_screen.dart';
import 'package:mindtrip/features/itinerary/presentation/screens/trip_details_screen.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_cubit.dart';
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
          ],
          child: child,
        );
      },
      routes: [
        AppTransitionRoute.fadeSlide(
          path: AppRoutes.myTrips,
          page: const TripsScreen(),
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

  static final addToTripRoutes = [
    GoRoute(
      path: AppRoutes.addToTripSelectTrip,
      parentNavigatorKey: AppRouter.rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubit = state.extra as AddToTripCubit?;
        if (cubit == null) {
          return BottomSheetPage(child: const SizedBox.shrink());
        }
        return BottomSheetPage(
          child: BlocProvider<AddToTripCubit>.value(
            value: cubit,
            child: AddToTripSheet(
              onBack: () => context.pop(),
              onCreateNew: () =>
                  context.push(AppRoutes.addToTripCreatePlan, extra: cubit),
              onTripSelected: (trip) async {
                final success = await cubit.selectTrip(trip);
                if (success && context.mounted) {
                  context.push(AppRoutes.addToTripSelectDay, extra: cubit);
                }
              },
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.addToTripSelectDay,
      parentNavigatorKey: AppRouter.rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubit = state.extra as AddToTripCubit?;
        if (cubit == null) {
          return BottomSheetPage(child: const SizedBox.shrink());
        }
        return BottomSheetPage(
          child: BlocProvider<AddToTripCubit>.value(
            value: cubit,
            child: SelectDaySheet(
              onBack: () => context.pop(),
              onClose: () {
                while (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.addToTripManage,
      parentNavigatorKey: AppRouter.rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubit = state.extra as AddToTripCubit?;
        if (cubit == null) {
          return BottomSheetPage(child: const SizedBox.shrink());
        }
        return BottomSheetPage(
          child: BlocProvider<AddToTripCubit>.value(
            value: cubit,
            child: ManagePlaceSheet(
              onClose: () {
                while (context.canPop()) {
                  context.pop();
                }
              },
              onMoveToDay: () async {
                final success = await cubit.loadHostTripItinerary();
                if (success && context.mounted) {
                  context.push(AppRoutes.addToTripSelectDay, extra: cubit);
                }
              },
              onMoveToTrip: () {
                cubit.clearSelection();
                context.push(AppRoutes.addToTripSelectTrip, extra: cubit);
              },
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.addToTripCreatePlan,
      parentNavigatorKey: AppRouter.rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubit = state.extra as AddToTripCubit?;
        if (cubit == null) {
          return BottomSheetPage(child: const SizedBox.shrink());
        }
        return BottomSheetPage(
          child: BlocProvider<AddToTripCubit>.value(
            value: cubit,
            child: CreateTripPlannerSheet(
              onBack: () => context.pop(),
              onClose: () {
                while (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
        );
      },
    ),
  ];
}
