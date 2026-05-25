import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';

class NavigaiotnStep extends StatelessWidget {
  const NavigaiotnStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      builder: (context, state) {
        final route = state.activeRoute;
        if (route == null || state.isRouteLoading) {
          return const SizedBox.shrink();
        }

        final steps = route.allSteps;
        final stepIndex = state.currentStepIndex;
        final currentStep = (stepIndex >= 0 && stepIndex < steps.length)
            ? steps[stepIndex]
            : null;

        // final instruction =
        //     currentStep?.instruction ??
        //     'Proceed to ${state.destinationName ?? "destination"}';
        final durationMin = state.formatDuration(route.duration.ceil());
        final distanceText = currentStep != null
            ? state.formatDistance(currentStep.distance)
            : '';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [AppShadows.mainElevationButton],
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Step number circle
                Center(
                  child: Icon(
                    _getManeuverIcon(
                      currentStep?.bannerType,
                      currentStep?.bannerModifier,
                    ),
                    size: 42.sp,
                    color: context.colorTheme.onSurface,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              distanceText,
                              style: AppTextStyles.h8SemiBold.copyWith(
                                color: context.colorTheme.onSurface,
                              ),
                            ),
                          ),
                          Text(
                            durationMin,
                            style: AppTextStyles.h9SemiBold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      Text(
                        currentStep?.bannerText ??
                            currentStep?.instruction ??
                            '',
                        style: context.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

IconData _getManeuverIcon(String? type, String? modifier) {
  if (type == null) return Icons.straight;
  switch (type) {
    case 'turn':
      if (modifier == 'left' ||
          modifier == 'slight left' ||
          modifier == 'sharp left') {
        return Icons.turn_left;
      }
      if (modifier == 'right' ||
          modifier == 'slight right' ||
          modifier == 'sharp right') {
        return Icons.turn_right;
      }
      return Icons.straight;
    case 'roundabout':
      return Icons.roundabout_left;
    case 'arrive':
      return Icons.flag;
    case 'depart':
      return Icons.trip_origin;
    case 'merge':
      return Icons.merge;
    case 'fork':
      return modifier?.contains('left') == true
          ? Icons.fork_left
          : Icons.fork_right;
    default:
      return Icons.straight;
  }
}
