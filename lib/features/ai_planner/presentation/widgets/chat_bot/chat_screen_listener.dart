import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class ChatScreenListener extends StatelessWidget {
  const ChatScreenListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AiPlannerCubit, AiPlannerState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == AiPlannerStatus.loading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const GeneratingDialog(),
              );
            } else if (state.status == AiPlannerStatus.success) {
              AppDialog.hideLoading(context);
            } else if (state.status == AiPlannerStatus.failure) {
              AppDialog.hideLoading(context);
              AppGlassSnackBar.showError(
                context: context,
                message: state.errorMessage.isEmpty
                    ? 'Failed to generate plan'
                    : state.errorMessage,
              );
            }
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
              context.go(
                '${AppRoutes.tripDetails}?tripId=${state.generatedTripId}',
              );
            } else if (state.tripsStatus == TripsStatus.error) {
              AppGlassSnackBar.showError(
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
