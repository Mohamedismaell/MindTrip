import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/location/cubit/location_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';
import 'package:mindtrip/features/map/presentation/widgets/map_action_button.dart';

class PlaceCardOverviewMap extends StatelessWidget {
  const PlaceCardOverviewMap({
    super.key,
    required this.place,
    this.imageUrl,
    required this.imageHeight,
    required this.contentHeight,
    required this.isSearchResult,
    required this.onAdd,
    required this.onRemove,
    this.heroTag,
  });

  final PlaceEntity place;
  final String? imageUrl;
  final double imageHeight;
  final double contentHeight;
  final bool isSearchResult;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final String? heroTag;
  @override
  Widget build(BuildContext context) {
    final placeLat = place.location.latitude;

    final placeLng = place.location.longitude;

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: heroTag != null
                  ? Hero(
                      tag: heroTag!,
                      transitionOnUserGestures: true,
                      child: AppCachedImage(
                        imagePath: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  : AppCachedImage(imagePath: imageUrl, fit: BoxFit.cover),
            ),

            Positioned(
              top: 12.h,
              right: 12.w,
              child: GestureDetector(
                onTap: () {
                  context.read<MapCubit>().selectPlace(place.id);
                },
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
                    Icons.keyboard_arrow_up_rounded,
                    size: 24.sp,
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

                  SizedBox(width: 10.w),

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

              // const Spacer(),
              SizedBox(height: 10.h),
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
                        RatingStars(rating: place.rating!, size: 18.sp),

                        SizedBox(width: 4.w),

                        Text(
                          place.rating.toString(),
                          style: AppTextStyles.h10SemiBold.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),

              // const Spacer(),
              SizedBox(height: 10.h),

              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<MapNavigationCubit, MapNavigationState>(
                      builder: (context, navState) {
                        return MapActionButton(
                          label: navState.isRouteLoading
                              ? "Loading..."
                              : "Show route",
                          icon: Icons.directions_rounded,
                          color: context.colorTheme.primary,
                          isFilled: true,
                          onTap: navState.isRouteLoading
                              ? null
                              : () {
                                  // Immediately disable button + jump to DriveTab
                                  context
                                      .read<MapNavigationCubit>()
                                      .beginLoading(
                                        destinationName: place.name,
                                      );
                                  context.read<MapCubit>().clearSelection();

                                  () async {
                                    final pos = await sl<LocationService>()
                                        .getCurrentLocation();

                                    if (pos != null && context.mounted) {
                                      final userPos = Position(
                                        pos.longitude,
                                        pos.latitude,
                                      );

                                      context
                                          .read<MapNavigationCubit>()
                                          .navigateSequential(
                                            [
                                              userPos,
                                              Position(placeLng, placeLat),
                                            ],
                                            [place.name],
                                          );
                                    }
                                  }();
                                },
                        );
                      },
                    ),
                  ),

                  SizedBox(width: 8.w),

                  isSearchResult
                      ? Expanded(
                          child: MapActionButton(
                            label: "Remove",
                            icon: Icons.delete_outline_rounded,
                            color: context.colorTheme.error,
                            isFilled: false,
                            onTap: () {
                              onAdd();

                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  if (context.mounted) {
                                    context.read<MapCubit>().removeSearchPlace(
                                      place.id,
                                    );
                                    context
                                        .read<MapNavigationCubit>()
                                        .stopNavigation();

                                    onRemove();
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: MapActionButton(
                            label: "Show map",
                            icon: Icons.map_rounded,
                            color: context.colorTheme.primary,
                            isFilled: false,
                            onTap: () {
                              context.read<MapCubit>().triggerFlyTo(
                                placeLat,
                                placeLng,
                              );

                              context.read<MapCubit>().dismissBottomSheet();
                            },
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
