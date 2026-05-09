import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';
import 'package:mindtrip/features/map/domain/entities/route_step.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_actions.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_images.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  const PlaceInfoBottomSheet({super.key});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final DraggableScrollableController _dragController =
      DraggableScrollableController();
  int _currentTab = 0;

  @override
  void dispose() {
    _dragController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _switchToTab(int tab) {
    if (_currentTab != tab) {
      setState(() => _currentTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Auto-switch to Drive tab when navigation starts loading
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) =>
              !prev.isRouteLoading && curr.isRouteLoading,
          listener: (context, state) => _switchToTab(1),
        ),
        // Auto-switch back to Place tab when navigation stops
        BlocListener<MapNavigationCubit, MapNavigationState>(
          listenWhen: (prev, curr) =>
              prev.activeRoute != null &&
              curr.activeRoute == null &&
              !curr.isRouteLoading,
          listener: (context, state) => _switchToTab(0),
        ),
      ],
      child: BlocBuilder<MapCubit, MapState>(
        buildWhen: (previous, current) {
          return previous.selectedPlace != current.selectedPlace ||
              previous.selectedGooglePlace != current.selectedGooglePlace ||
              previous.selectedPlacePhotoUrls !=
                  current.selectedPlacePhotoUrls ||
              previous.isBottomSheetVisible != current.isBottomSheetVisible;
        },
        builder: (context, state) {
          final isVisible = state.isBottomSheetVisible;
          final place = state.selectedPlace;
          final googlePlace = state.selectedGooglePlace;
          final photoUrls = state.selectedPlacePhotoUrls;

          return DraggableScrollableSheet(
            controller: _dragController,
            initialChildSize: isVisible ? 0.45 : 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.45,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                      child: Container(
                        width: 50.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2.5.r),
                        ),
                      ),
                    ),
                    // Tab bar
                    _buildTabBar(context),
                    // Content
                    Expanded(
                      child: _currentTab == 0
                          ? _buildPlaceTab(
                              context,
                              scrollController,
                              place,
                              googlePlace,
                              photoUrls,
                            )
                          : _buildDriveTab(context, scrollController),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  //  Tab Bar

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildTabItem(context, 'Place', Icons.place_outlined, 0),
          SizedBox(width: 12.w),
          _buildTabItem(context, 'Drive', Icons.directions_car_outlined, 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
    final isSelected = _currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _switchToTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? context.colorTheme.primary
                    : Colors.transparent,
                width: 2.5.w,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected
                    ? context.colorTheme.primary
                    : context.colorTheme.outline,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: isSelected
                      ? context.colorTheme.primary
                      : context.colorTheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Place Tab

  Widget _buildPlaceTab(
    BuildContext context,
    ScrollController scrollController,
    PlaceModel? place,
    GooglePlaceEntity? googlePlace,
    List<String>? photoUrls,
  ) {
    if (googlePlace != null) {
      return _buildGooglePlaceContent(
        context,
        scrollController,
        googlePlace,
        photoUrls,
      );
    } else if (place != null) {
      return _buildContent(context, scrollController, place);
    }
    return Center(
      child: Text(
        'Tap a place on the map to see details',
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorTheme.outline,
        ),
      ),
    );
  }

  Widget _buildGooglePlaceContent(
    BuildContext context,
    ScrollController scrollController,
    GooglePlaceEntity place,
    List<String>? photoUrls,
  ) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      children: [
        if (photoUrls != null && photoUrls.isNotEmpty)
          PlaceImages(
            photoUrls: photoUrls,
            scrollController: _scrollController,
          ),
        // Name & Category & Rating
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.displayName,
                    style: context.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8.h),
                  if (place.rating != null) ...[
                    Row(
                      children: [
                        RatingStars(rating: place.rating!, size: 22.sp),
                        SizedBox(width: 4.h),
                        Text(
                          place.rating.toString(),
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 8.h),
                  if (place.userRatingCount != null &&
                      place.userRatingCount! > 0)
                    Text(
                      '${place.userRatingCount} Reviews ',
                      style: AppTextStyles.h8SemiBold,
                    ),
                ],
              ),
            ),
            if (place.primaryType != null)
              Chip(
                label: Text(
                  place.primaryType!.replaceAll('_', ' '),
                  style: context.textTheme.labelLarge,
                ),
                backgroundColor: context.colorTheme.primary.withValues(
                  alpha: 0.2,
                ),
                side: BorderSide.none,
              ),
          ],
        ),
        SizedBox(height: 16.h),
        // Description
        if (place.editorialSummary != null)
          Text(place.editorialSummary!, style: context.textTheme.bodyMedium),
        // Opening Hours
        if (place.openingHours != null)
          Text(
            place.openingHours!.openNow == true ? 'Open Now' : 'Closed',
            style: AppTextStyles.h8SemiBold.copyWith(
              color: place.openingHours!.openNow == true
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        SizedBox(height: 24.h),
        PlaceActions(
          latitude: place.latitude,
          longitude: place.longitude,
          dragController: _dragController,
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    ScrollController scrollController,
    PlaceModel place,
  ) {
    final photoUrls = place.imageUrls;
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      children: [
        if (photoUrls != null)
          PlaceImages(
            photoUrls: photoUrls,
            scrollController: _scrollController,
          ),
        // Name & Rating
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name, style: context.textTheme.headlineSmall),
                SizedBox(height: 8.h),
                if (place.rating != null) ...[
                  Row(
                    children: [
                      RatingStars(rating: place.rating!, size: 22.sp),
                      SizedBox(width: 4.h),
                      Text(
                        place.rating.toString(),
                        style: context.textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 8.h),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(height: 24.h),
        PlaceActions(
          latitude: place.location.latitude,
          longitude: place.location.longitude,
          dragController: _dragController,
        ),
      ],
    );
  }

  //  Drive Tab

  Widget _buildDriveTab(
    BuildContext context,
    ScrollController scrollController,
  ) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      builder: (context, state) {
        if (state.isRouteLoading) {
          return Center(
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
          );
        }

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
            // Profile selector – 4 chips in a row
            _buildProfileChips(context, state.selectedProfile),
            SizedBox(height: 20.h),

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
        );
      },
    );
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

  // ─── Profile Chips (always-visible row of 4) ─────────────────────

  Widget _buildProfileChips(BuildContext context, NavigationProfile selected) {
    return Row(
      children: NavigationProfile.values.map((profile) {
        final isSelected = selected == profile;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () =>
                  context.read<MapNavigationCubit>().setProfile(profile),
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
                            : context.colorTheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
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
}
