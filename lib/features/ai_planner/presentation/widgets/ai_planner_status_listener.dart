import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';

class AiPlannerStatusListener extends StatelessWidget {
  const AiPlannerStatusListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiPlannerCubit, AiPlannerState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AiPlannerStatus.generatingPlan:
            _showLoading(
              context,
              const GeneratingDialog(
                title: 'Generating itinerary...',
                description: 'Our AI is creating the perfect trip for you.',
              ),
            );
            break;

          case AiPlannerStatus.savingTrip:
            _showLoading(
              context,
              const GeneratingDialog(
                title: 'Saving itinerary...',
                description: 'Almost done. Saving your itinerary securely.',
              ),
            );
            break;

          case AiPlannerStatus.success:
            AppDialog.hideLoading(context);

            final tripId = state.savedTripId;
            if (tripId == null || tripId.isEmpty) {
              AppGlassSnackBar.showError(
                context: context,
                message: 'Your itinerary was saved but could not be opened.',
              );
              return;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('${AppRoutes.tripDetails}?tripId=$tripId');
            });

            break;

          case AiPlannerStatus.generateFailure:
            AppDialog.hideLoading(context);

            AppGlassSnackBar.showError(
              context: context,
              message: 'Couldn\'t generate your trip. Please try again.',
            );
            break;

          case AiPlannerStatus.saveFailure:
            AppDialog.hideLoading(context);

            AppDialog.show(
              context: context,
              title: 'Could not save trip',
              description:
                  'Your itinerary was generated but couldn\'t be saved.',
              primaryText: 'Retry',
              secondaryText: 'Close',
              icon: Icons.error_outline,
              onPrimary: () {
                context.read<AiPlannerCubit>().saveGeneratedTrip();
              },
            );
            break;

          case AiPlannerStatus.initial:
          case AiPlannerStatus.generated:
            break;
        }
      },
      child: child,
    );
  }

  void _showLoading(BuildContext context, Widget dialog) {
    AppDialog.hideLoading(context);

    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }
}
