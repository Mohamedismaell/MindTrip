import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/location/cubit/location_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_navigation_cubit.dart';
import 'place_tab.dart';
import '../cubit/map_state.dart';

class PlaceCardRow extends StatefulWidget {
  const PlaceCardRow({super.key});

  @override
  State<PlaceCardRow> createState() => _PlaceCardRowState();
}

class _PlaceCardRowState extends State<PlaceCardRow> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _isUserSwipe = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _jumpToIndex(int index) {
    if (!_pageController.hasClients) return;
    _isUserSwipe = false;
    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        )
        .then((_) => _isUserSwipe = true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (prev, curr) =>
          prev.selectedPlace != curr.selectedPlace ||
          prev.annotations != curr.annotations,
      listener: (context, state) {
        if (state.annotations != context.read<MapCubit>().state.annotations) {
          _currentPage = 0;
        }
        if (state.selectedPlace != null) {
          final index = state.annotations.indexWhere(
            (a) => a.place.id == state.selectedPlace!.id,
          );
          if (index != -1 && index != _currentPage) {
            _jumpToIndex(index);
          }
        }
      },
      buildWhen: (prev, curr) =>
          prev.annotations != curr.annotations ||
          prev.selectedPlace != curr.selectedPlace,
      builder: (context, state) {
        if (state.annotations.isEmpty) return const SizedBox.shrink();

        final isExpanded = state.isBottomSheetVisible;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isExpanded ? 0.7.sh : 310.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: state.annotations.length,
            onPageChanged: (index) {
              _currentPage = index;
              if (_isUserSwipe) {
                final entry = state.annotations[index];
                context.read<MapCubit>().triggerFlyTo(
                  entry.place.location.latitude,
                  entry.place.location.longitude,
                );
              }
            },
            itemBuilder: (context, index) {
              final entry = state.annotations[index];
              final place = entry.place;
              final isSelected = state.selectedPlace?.id == place.id;
              final imageUrl =
                  (place.imageUrls != null && place.imageUrls!.isNotEmpty)
                  ? place.imageUrls!.first
                  : null;

              final googlePlace = isSelected ? state.selectedGooglePlace : null;
              final statePhotoUrls = isSelected
                  ? state.selectedPlacePhotoUrls
                  : null;
              final finalPhotoUrls =
                  statePhotoUrls != null && statePhotoUrls.isNotEmpty
                  ? statePhotoUrls
                  : place.imageUrls;

              return Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (isSelected && isExpanded) {
                        context.read<MapCubit>().dismissBottomSheet();
                      } else {
                        context.read<MapCubit>().selectPlace(place.id);
                      }
                    },
                    child: Container(
                      height: (isSelected && isExpanded) ? null : 290,
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: isSelected
                              ? context.colorTheme.primary
                              : Colors.transparent,
                          width: 2.5,
                        ),
                        boxShadow: [AppShadows.mapToolButtons],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21.5.r),
                        //Todo: Edit the expanded state to show the details in a better way
                        child: (isSelected && isExpanded)
                            ? SingleChildScrollView(
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        PlaceTab(
                                          place: place,
                                          googlePlace: googlePlace,
                                          photoUrls: finalPhotoUrls,
                                          imagesScrollController:
                                              ScrollController(),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 12.h,
                                      right: 12.w,
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<MapCubit>()
                                            .dismissBottomSheet(),
                                        child: Container(
                                          width: 32.w,
                                          height: 32.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              AppShadows.tourPackagesCard,
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 18.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            // If it's not currently expanded view, show basic card overview mode
                            : _buildCardOverview(
                                context,
                                place,
                                googlePlace,
                                finalPhotoUrls,
                                isSelected,
                                isExpanded,
                                imageUrl,
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: isFilled ? 3 : 2,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isFilled ? color : Colors.white,
            borderRadius: BorderRadius.circular(100.r),
            border: isFilled
                ? null
                : Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.sp, color: isFilled ? Colors.white : color),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.h10Bold.copyWith(
                  color: isFilled ? Colors.white : color,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardOverview(
    BuildContext context,
    PlaceModel place,
    GooglePlaceEntity? googlePlace,
    List<String>? finalPhotoUrls,
    bool isSelected,
    bool isExpanded,
    String? imageUrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with overlay sequence badge
        AspectRatio(
          aspectRatio: 16 / 9,

          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: AppCachedImage(imagePath: imageUrl, fit: BoxFit.cover),
              ),
              //Todo Need to be Connected with the saved Cubit and widget
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [AppShadows.tourPackagesCard],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.bookmark_rounded,
                    size: 18.sp,
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content Section
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and distance/time metrics
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.name,
                        style: AppTextStyles.h8Bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        final distance = context
                            .read<LocationCubit>()
                            .getDistanceBetween(
                              placeLat: place.location.latitude,
                              placeLng: place.location.longitude,
                            );
                        return Text(
                          state.formatDistance(distance),
                          style: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                // Subtitle / Rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.description ?? "No description available",
                        style: AppTextStyles.h10Regular.copyWith(
                          color: context.colorTheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                  ],
                ),
                const Spacer(),
                // Action Buttons Row
                Row(
                  children: [
                    _buildActionButton(
                      context: context,
                      label: "Show route",
                      icon: Icons.directions_rounded,
                      color: context.colorTheme.primary,
                      isFilled: true,
                      onTap: () async {
                        final pos = await sl<LocationService>()
                            .getCurrentLocation();
                        if (pos != null && context.mounted) {
                          final userPos = Position(pos.longitude, pos.latitude);
                          context.read<MapNavigationCubit>().navigateToPosition(
                            userPos,
                            place.location.latitude,
                            place.location.longitude,
                          );
                        }
                      },
                    ),
                    SizedBox(width: 8.w),
                    _buildActionButton(
                      context: context,
                      label: "Call",
                      icon: Icons.call_rounded,
                      color: context.colorTheme.primary,
                      isFilled: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 8.w),
                    _buildActionButton(
                      context: context,
                      label: "Share",
                      icon: Icons.share_rounded,
                      color: context.colorTheme.primary,
                      isFilled: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
