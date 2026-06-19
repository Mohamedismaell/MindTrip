import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';
import 'package:mindtrip/features/map/domain/utils/distance_utils.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_action_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DriveTab extends StatelessWidget {
  const DriveTab({super.key});

  //ToDo: Need to be checked
  Future<void> navigateAll(BuildContext context) async {
    final position = await sl<LocationService>().getCurrentLocation();
    if (context.mounted && position != null) {
      final userPosition = Position(position.longitude, position.latitude);
      final annotations = context.read<MapCubit>().state.annotations;
      final waypoints = [userPosition];
      final placeNames = <String>[];

      final isTripMode = context.read<MapCubit>().state.hasTripDays;

      if (isTripMode) {
        // In trip mode, route in strict list order
        for (final entry in annotations) {
          waypoints.add(
            Position(
              entry.place.location.longitude,
              entry.place.location.latitude,
            ),
          );
          placeNames.add(entry.place.name);
        }
      } else {
        final unvisited = List.of(annotations);
        var currentLat = position.latitude;
        var currentLng = position.longitude;

        while (unvisited.isNotEmpty) {
          final nearest = DistanceUtils.findNearestAnnotation(
            unvisited,
            currentLat,
            currentLng,
          );
          if (nearest != null) {
            waypoints.add(
              Position(
                nearest.place.location.longitude,
                nearest.place.location.latitude,
              ),
            );
            placeNames.add(nearest.place.name);
            unvisited.remove(nearest);
            currentLat = nearest.place.location.latitude;
            currentLng = nearest.place.location.longitude;
          } else {
            break;
          }
        }
      }

      context.read<MapNavigationCubit>().navigateAll(waypoints, placeNames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      buildWhen: (previous, current) {
        return previous.activeRoute != current.activeRoute ||
            previous.selectedProfile != current.selectedProfile ||
            previous.isRouteLoading != current.isRouteLoading;
        // previous.routeError != current.routeError;
        // previous.currentStepIndex != current.currentStepIndex;
      },
      builder: (context, navigationState) {
        if (navigationState.activeRoute == null &&
            !navigationState.isRouteLoading) {
          return _buildEmptyRoute(context, () => navigateAll(context));
        }

        // Error state
        if (navigationState.routeError != null) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Column(
              children: [
                Skeleton.keep(
                  child: _buildProfileChips(
                    context,
                    navigationState.selectedProfile,
                  ),
                ),
                SizedBox(height: 14.h),
                _buildDriveError(context, navigationState.routeError!),
              ],
            ),
          );
        }

        final isLoading = navigationState.isRouteLoading;
        final route = navigationState.activeRoute;

        final distanceText = route != null
            ? navigationState.formatDistance(route.distance)
            : (isLoading ? '0.0 km' : '5.0');

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Skeletonizer(
            enabled: isLoading,
            justifyMultiLineText: true,
            enableSwitchAnimation: true,
            ignorePointers: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (navigationState.destinationName != null) ...[
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${navigationState.destinationName}',
                          style: AppTextStyles.h8Bold,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          distanceText,
                          style: AppTextStyles.h9SemiBold,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                ],
                _buildProfileChips(context, navigationState.selectedProfile),
                SizedBox(height: 14.h),
                Column(
                  children: [
                    SizedBox(height: 8.h),
                    Skeleton.keep(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomOutlinedButton(
                              onPressed: () {
                                context
                                    .read<MapNavigationCubit>()
                                    .stopNavigation();
                              },
                              actionIcon: Icons.close,
                              text: 'Stop',
                              textStyle: context.textTheme.labelLarge?.copyWith(
                                color: context.colorTheme.error,
                              ),
                              color: context.colorTheme.error,
                              padding: EdgeInsets.symmetric(
                                vertical: 7.r,
                                horizontal: 5.r,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            flex: 2,
                            child: CustomOutlinedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => context
                                        .read<MapNavigationCubit>()
                                        .advanceToNextLeg(),
                              actionIcon:
                                  navigationState.currentLegIndex >=
                                      navigationState.totalLegs - 1
                                  ? Icons.check
                                  : Icons.arrow_forward_ios,
                              text:
                                  navigationState.currentLegIndex >=
                                      navigationState.totalLegs - 1
                                  ? 'Finish Trip'
                                  : 'Next Place (${navigationState.currentLegIndex + 1}/${navigationState.totalLegs})',
                              color: context.colorTheme.primary,
                              textStyle: context.textTheme.labelLarge?.copyWith(
                                color: isLoading
                                    ? context.colorTheme.outline
                                    : context.colorTheme.primary,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 7.r,
                                horizontal: 5.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ],
            ),
          ),
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
          Icon(Icons.error_outline, size: 32.sp, color: Colors.red),
          SizedBox(height: 6.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: 8.h),
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
  final navigationState = context.watch<MapNavigationCubit>().state;
  final route = navigationState.activeRoute;
  final durationMin = navigationState.formatDuration(
    route?.duration.ceil() ?? 0,
  );
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: NavigationProfile.values.map((profile) {
        final isSelected = selected == profile;

        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GestureDetector(
            onTap: () {
              context.read<MapNavigationCubit>().setProfile(profile);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colorTheme.primary
                    : context.colorTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: isSelected
                      ? context.colorTheme.primary
                      : context.colorTheme.outline.withValues(),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Skeleton.keep(
                    child: Icon(
                      profile.icon,
                      size: 18.sp,
                      color: isSelected
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.onSurface,
                    ),
                  ),

                  SizedBox(width: 8.w),
                  Text(
                    durationMin,
                    style: AppTextStyles.h10SemiBold.copyWith(
                      color: isSelected
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

//  Empty Route

Widget _buildEmptyRoute(BuildContext context, VoidCallback onTap) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(32.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.directions_outlined,
            size: 32.sp,
            color: context.colorTheme.outline,
          ),
          SizedBox(height: 6.h),
          Text(
            'Select a place and tap\n"Show route" to get directions or ',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
          SizedBox(height: 12.h),
          MapActionButton(
            onTap: onTap,
            icon: Icons.directions_car,
            label: 'Start Trip',
            color: context.colorTheme.primary,
            isFilled: true,
          ),
        ],
      ),
    ),
  );
}
