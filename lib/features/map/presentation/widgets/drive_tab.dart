import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';
import 'package:mindtrip/features/map/domain/entities/route_step.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';

class DriveTab extends StatelessWidget {
  const DriveTab({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      builder: (context, state) {
        if (state.routeError != null) {
          return _buildDriveError(context, state.routeError!);
        }

        final route = state.activeRoute;
        if (route == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions_outlined,
                    size: 48.sp,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Select a place and tap\n"Navigate Here" to get directions',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final distanceKm = (route.distance / 1000).toStringAsFixed(1);
        final durationMin = (route.duration / 60).ceil();
        final allSteps = route.allSteps;

        return ListView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          children: [
            // Profile selector
            _buildProfileChips(context, state.selectedProfile),
            SizedBox(height: 20.h),

            if (state.isRouteLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(strokeWidth: 2),
                      SizedBox(height: 16.h),
                      Text(
                        'Calculating route...',
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              // Route summary card
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: context.colorTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      state.selectedProfile.icon,
                      color: context.colorTheme.onPrimaryContainer,
                      size: 32.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$durationMin min',
                            style: context.textTheme.titleLarge?.copyWith(
                              color: context.colorTheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$distanceKm km · ${state.selectedProfile.label}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorTheme.onPrimaryContainer
                                  .withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Step-by-step instructions
              if (allSteps.isNotEmpty) ...[
                Text(
                  'Directions',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                ...allSteps.asMap().entries.map(
                  (entry) => _buildStepItem(context, entry.value, entry.key),
                ),
              ],
              SizedBox(height: 16.h),

              // Stop navigation button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      context.read<MapNavigationCubit>().stopNavigation(),
                  icon: const Icon(Icons.close),
                  label: const Text('Stop Navigation'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colorTheme.error,
                    side: BorderSide(color: context.colorTheme.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ],
        );
      },
    );
  }
}

Widget _buildDriveError(BuildContext context, String error) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(32.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
          SizedBox(height: 12.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () =>
                context.read<MapNavigationCubit>().stopNavigation(),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    ),
  );
}

//  Profile Chips

Widget _buildProfileChips(BuildContext context, NavigationProfile selected) {
  return Row(
    children: NavigationProfile.values.map((profile) {
      final isSelected = selected == profile;
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: GestureDetector(
            onTap: () => context.read<MapNavigationCubit>().setProfile(profile),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colorTheme.primary
                    : context.colorTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    profile.icon,
                    size: 20.sp,
                    color: isSelected
                        ? context.colorTheme.onPrimary
                        : context.colorTheme.onSurface.withValues(alpha: 0.6),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    profile.label,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}

//  Step Item

Widget _buildStepItem(BuildContext context, RouteStep step, int index) {
  final distanceText = step.distance >= 1000
      ? '${(step.distance / 1000).toStringAsFixed(1)} km'
      : '${step.distance.toInt()} m';

  return Padding(
    padding: EdgeInsets.only(bottom: 4.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step number circle
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: context.colorTheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              _getManeuverIcon(step.bannerType, step.bannerModifier),
              size: 16.sp,
              color: context.colorTheme.primary,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.bannerText ?? step.instruction,
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              Text(
                distanceText,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Divider(height: 16.h, color: Colors.grey.shade200),
            ],
          ),
        ),
      ],
    ),
  );
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
