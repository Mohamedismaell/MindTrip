import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/drive_tab.dart';
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
            maxChildSize: 0.7,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [AppShadows.mainElevationButton],
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
                              _scrollController,
                              place,
                              googlePlace,
                              photoUrls,
                            )
                          : DriveTab(scrollController: _scrollController),
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
}
