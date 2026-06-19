import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_snackbar.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class AiPlannerFlowListnener extends StatelessWidget {
  const AiPlannerFlowListnener({
    super.key,
    required PageController pageController,
    required this.child,
  }) : _pageController = pageController;
  final PageController _pageController;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AiPlannerCubit, AiPlannerState>(
          listenWhen: (previous, current) =>
              previous.currentPage != current.currentPage,
          listener: (context, state) {
            _pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
            );
          },
        ),
        BlocListener<TripsCubit, TripsState>(
          listenWhen: (previous, current) =>
              previous.isGenerating != current.isGenerating ||
              previous.generatedTripId != current.generatedTripId,
          listener: (context, state) {
            if (state.isGenerating) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const GeneratingDialog(),
              );
            } else if (state.generatedTripId != null) {
              context.pop();
              //Todo: check navigation
              context.go(
                '${AppRoutes.tripDetails}?tripId=${state.generatedTripId}',
              );
            } else if (state.tripsStatus == TripsStatus.error) {
              AppSnackBar.showError(
                context: context,
                message: state.errorMessage ?? 'Generation failed',
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
