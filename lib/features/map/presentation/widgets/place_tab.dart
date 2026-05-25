import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/location/cubit/location_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_action_button.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_images.dart';

class PlaceTab extends StatelessWidget {
  const PlaceTab({
    super.key,
    this.place,
    this.googlePlace,
    this.photoUrls,
    required this.imagesScrollController,
    this.dragController,
  });
  final PlaceModel? place;
  final GooglePlaceEntity? googlePlace;
  final List<String>? photoUrls;
  final ScrollController imagesScrollController;
  final DraggableScrollableController? dragController;
  @override
  Widget build(BuildContext context) {
    if (googlePlace != null) {
      return _buildGooglePlaceContent(context, googlePlace!, photoUrls!);
    } else if (place != null) {
      return _buildContent(context, place!);
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100.h),
        child: Text(
          'Tap a place on the map to see details',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorTheme.outline,
          ),
        ),
      ),
    );
  }

  Widget _buildGooglePlaceContent(
    BuildContext context,
    GooglePlaceEntity place,
    List<String>? photoUrls,
  ) {
    final placeLat = place.latitude;
    final placeLng = place.longitude;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (photoUrls != null && photoUrls.isNotEmpty)
          PlaceImages(
            photoUrls: photoUrls,
            scrollController: imagesScrollController,
            heroTag: googlePlace!.placeId,
          ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(place.displayName, style: AppTextStyles.h8Bold),
                  ),
                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final distance = context
                          .read<LocationCubit>()
                          .getDistanceBetween(
                            placeLat: placeLat!,
                            placeLng: placeLng!,
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

              SizedBox(height: 14.h),
              // Description
              if (place.editorialSummary != null)
                Text(
                  place.editorialSummary!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              SizedBox(height: 12.h),

              //Todo: change it to be stack on the image if its good
              // if (place.primaryType != null)
              //   Chip(
              //     label: Text(
              //       place.primaryType!.replaceAll('_', ' '),
              //       style: context.textTheme.labelLarge,
              //     ),
              //     backgroundColor: context.colorTheme.primary.withValues(
              //       alpha: 0.2,
              //     ),
              //     side: BorderSide.none,
              //   ),
              // SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (place.userRatingCount != null &&
                      place.userRatingCount! > 0)
                    Text(
                      '${place.userRatingCount}  Reviews ',
                      style: AppTextStyles.h8SemiBold,
                    ),

                  // Opening Hours
                  if (place.openingHours != null)
                    Text(
                      place.openingHours!.openNow == true
                          ? 'Open Now'
                          : 'Closed Now',
                      style: AppTextStyles.h8SemiBold.copyWith(
                        color: place.openingHours!.openNow == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),

              if (place.rating != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingStars(rating: place.rating!, size: 22.sp),
                    SizedBox(width: 4.h),
                    Expanded(
                      child: Text(
                        place.rating.toString(),
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MapActionButton(
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
                          placeLat!,
                          placeLng!,
                        );
                        context.read<MapCubit>().dismissBottomSheet();
                      }
                    },
                  ),
                  SizedBox(width: 8.w),
                  MapActionButton(
                    label: "Show on map",
                    icon: Icons.map_rounded,
                    color: context.colorTheme.primary,
                    isFilled: true,
                    onTap: () async {
                      if (placeLat == null || placeLng == null) return;

                      // if (dragController?.isAttached ?? false) {
                      //   await dragController?.animateTo(
                      //     0.1,
                      //     duration: const Duration(milliseconds: 300),
                      //     curve: Curves.easeInOut,
                      //   );
                      // }

                      if (context.mounted) {
                        context.read<MapCubit>().triggerFlyTo(
                          placeLat,
                          placeLng,
                        );
                        context.read<MapCubit>().dismissBottomSheet();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PlaceModel place) {
    final photoUrls = place.imageUrls;
    final placeLat = place.location.latitude;
    final placeLng = place.location.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (photoUrls != null && photoUrls.isNotEmpty)
          PlaceImages(
            photoUrls: photoUrls,
            scrollController: imagesScrollController,
            heroTag: 'place-${place.id}',
          ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE + DISTANCE
              Row(
                children: [
                  Expanded(
                    child: Text(place.name, style: AppTextStyles.h8Bold),
                  ),

                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final distance = context
                          .read<LocationCubit>()
                          .getDistanceBetween(
                            placeLat: placeLat,
                            placeLng: placeLng,
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

              SizedBox(height: 14.h),

              /// DESCRIPTION
              if (place.description != null)
                Text(
                  place.description!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),

              SizedBox(height: 12.h),

              /// REVIEWS + CATEGORY
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (place.reviewCount != null)
                    Text(
                      '${place.reviewCount} Reviews',
                      style: AppTextStyles.h8SemiBold,
                    ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Text(
                      place.category.name.replaceAll('_', ' '),
                      style: AppTextStyles.h10SemiBold.copyWith(
                        color: context.colorTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              /// RATING + PRICE + BADGE
              Row(
                children: [
                  if (place.rating != null) ...[
                    RatingStars(rating: place.rating!, size: 22.sp),

                    SizedBox(width: 4.w),

                    Text(
                      place.rating.toString(),
                      style: context.textTheme.labelLarge,
                    ),

                    SizedBox(width: 12.w),
                  ],

                  if (place.price != null)
                    Text(
                      '\$${place.price!.toStringAsFixed(0)}',
                      style: AppTextStyles.h9SemiBold,
                    ),
                ],
              ),

              SizedBox(height: 24.h),

              /// ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MapActionButton(
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
                          placeLat,
                          placeLng,
                        );

                        context.read<MapCubit>().dismissBottomSheet();
                      }
                    },
                  ),

                  SizedBox(width: 8.w),

                  MapActionButton(
                    label: "Show on map",
                    icon: Icons.map_rounded,
                    color: context.colorTheme.primary,
                    isFilled: true,
                    onTap: () async {
                      if (context.mounted) {
                        context.read<MapCubit>().triggerFlyTo(
                          placeLat,
                          placeLng,
                        );

                        context.read<MapCubit>().dismissBottomSheet();
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    );
  }
}
