import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state.flowStatus == AddToTripFlowStatus.added) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final canPopInternally =
            state.flowStatus == AddToTripFlowStatus.selectDay ||
            state.flowStatus == AddToTripFlowStatus.creatingNew ||
            (state.flowStatus == AddToTripFlowStatus.selectTrip &&
                state.placeAlreadyInTrip);

        return PopScope(
          canPop: !canPopInternally,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (state.flowStatus == AddToTripFlowStatus.selectDay ||
                state.flowStatus == AddToTripFlowStatus.creatingNew) {
              context.read<AddToTripCubit>().backToSelectTrip();
            } else if (state.flowStatus == AddToTripFlowStatus.selectTrip &&
                state.placeAlreadyInTrip) {
              context.read<AddToTripCubit>().openManage();
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),

            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _buildCurrentSheet(state.flowStatus),
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
        return const AddToTripSheet(key: ValueKey('select_trip'));
      case AddToTripFlowStatus.selectDay:
        return const SelectDaySheet(key: ValueKey('select_day'));
      case AddToTripFlowStatus.creatingNew:
        return const CreateTripPlannerSheet(key: ValueKey('creating_new'));
      case AddToTripFlowStatus.added:
        return const SizedBox.shrink();
    }
  }
}
// transitionBuilder: (child, animation) {
//               final isEntering = animation.status != AnimationStatus.reverse;
//               final offsetTween = Tween<Offset>(
//                 begin: Offset(isEntering ? 1.0 : -1.0, 0),
//                 end: Offset.zero,
//               );
//               return SlideTransition(
//                 position: offsetTween.animate(
//                   CurvedAnimation(
//                     parent: animation,
//                     curve: Curves.easeOutCubic,
//                   ),
//                 ),