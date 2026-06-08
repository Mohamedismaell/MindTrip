import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/add_to_trip_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/manage_place_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/select_day_sheet.dart';

class AddToTripFlowWrapper extends StatelessWidget {
  const AddToTripFlowWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listenWhen: (prev, curr) => prev.flowStatus != curr.flowStatus,
      listener: (context, state) {
        // Handled internally by individual sheets through success dialogs
      },
      builder: (context, state) {
        final canPopInternally =
            state.flowStatus != AddToTripFlowStatus.initial &&
            state.flowStatus != AddToTripFlowStatus.selectTrip &&
            state.flowStatus != AddToTripFlowStatus.managing;

        final shouldHandleInternally =
            canPopInternally ||
            (state.flowStatus == AddToTripFlowStatus.selectTrip &&
                state.placeAlreadyInTrip);

        return PopScope(
          canPop: !shouldHandleInternally,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            context.read<AddToTripCubit>().handleBack();
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 29.h,
                bottom: 24.h,
              ),
              decoration: BoxDecoration(
                color: context.colorTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: _buildCurrentSheet(state.flowStatus),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentSheet(AddToTripFlowStatus status) {
    switch (status) {
      case AddToTripFlowStatus.managing:
        return const ManagePlaceSheet(key: ValueKey('managing'));
      case AddToTripFlowStatus.selectTrip:
      case AddToTripFlowStatus.initial:
        return AddToTripSheet(
          key: const ValueKey('select_trip'),
        );
      case AddToTripFlowStatus.selectDay:
        return SelectDaySheet(
          key: const ValueKey('select_day'),
        );
      case AddToTripFlowStatus.creatingNew:
        return const CreateTripPlannerSheet(key: ValueKey('creating_new'));
      case AddToTripFlowStatus.added:
        return const SizedBox.shrink();
    }
  }
}