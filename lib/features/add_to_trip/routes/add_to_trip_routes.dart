import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/routes/app_transition_route.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/add_to_trip_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/manage_place_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/select_day_sheet.dart';

class AddToTripRoutes {
  static final routes = [
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
                // final success = await cubit.selectTrip(trip);
                // if (success && context.mounted) {
                context.push(AppRoutes.addToTripSelectDay, extra: cubit);
                // }
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
                // final success = await cubit.loadHostTripItinerary();
                // if (success && context.mounted) {
                context.push(AppRoutes.addToTripSelectDay, extra: cubit);
                // }
              },
              onMoveToTrip: () {
                // cubit.clearSelection();
                // context.push(AppRoutes.addToTripSelectTrip, extra: cubit);
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
