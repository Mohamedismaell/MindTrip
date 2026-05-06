import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' show Position;
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/place_category.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  const PlaceInfoBottomSheet({super.key});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  @override
  void dispose() {
    _dragController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) {
        return previous.selectedPlace != current.selectedPlace ||
            previous.selectedGooglePlace != current.selectedGooglePlace ||
            previous.selectedPlacePhotoUrls != current.selectedPlacePhotoUrls ||
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
          maxChildSize: 0.8,
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
                  // BoxShadow(
                  //   color: Colors.black12,
                  //   blurRadius: 10,
                  //   spreadRadius: 2,
                  // ),
                ],
              ),
              child: googlePlace != null
                  ? _buildGooglePlaceContent(
                      context,
                      scrollController,
                      googlePlace,
                      photoUrls,
                    )
                  : place != null
                  ? _buildContent(context, scrollController, place)
                  : const SizedBox(),
            );
          },
        );
      },
    );
  }

  Widget _buildGooglePlaceContent(
    BuildContext context,
    ScrollController scrollController,
    GooglePlaceEntity place,
    List<String> photoUrls,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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

          Expanded(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 20.h),
              children: [
                // Hero Image (First Photo)
                if (photoUrls.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),

                    //Todo change with skeltonizer
                    child: AppCachedImage(
                      imageUrl: photoUrls.first,
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.sp,
                      color: Colors.grey,
                    ),
                  ),
                SizedBox(height: 16.h),

                // Photo Carousel
                if (photoUrls.length > 1)
                  SizedBox(
                    height: 90.h,
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,

                      thickness: 2.w,

                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: photoUrls.length <= 3
                            ? _buildFewImages(photoUrls)
                            : _buildImageList(photoUrls, _scrollController),
                      ),
                    ),
                  ),
                SizedBox(height: 16.h),

                //Name & Category & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        // : const SizedBox(),
                      ],
                    ),
                    const Spacer(),
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
                  Text(
                    place.editorialSummary!,
                    style: context.textTheme.bodyMedium,
                  ),
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

                // // Address
                // if (place.formattedAddress != null)
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Icon(
                //         Icons.location_on,
                //         color: context.colorTheme.primary,
                //         size: 20.sp,
                //       ),
                //       SizedBox(width: 8.w),
                //       Expanded(
                //         child: Text(
                //           place.formattedAddress!,
                //           style: context.textTheme.bodySmall,
                //         ),
                //       ),
                //     ],
                //   ),
                // SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: FilledButton.icon(
                          onPressed: () async {
                            if (place.latitude == null ||
                                place.longitude == null) {
                              return;
                            }
                            final locationService = sl<LocationService>();
                            final position = await locationService
                                .getCurrentLocation();
                            if (position != null && context.mounted) {
                              // TODO: MapCubit route generation for Google Place
                              // We will need to adjust route logic or mock a PlaceModel
                              context.read<MapCubit>().dismissBottomSheet();
                            }
                          },
                          icon: const Icon(Icons.directions),
                          label: const Text('Navigate Here'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: FilledButton.icon(
                          onPressed: () async {
                            if (place.latitude != null &&
                                place.longitude != null) {
                              if (_dragController.isAttached) {
                                await _dragController.animateTo(
                                  0.1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if (context.mounted) {
                                context.read<MapCubit>().triggerFlyTo(
                                  place.latitude!,
                                  place.longitude!,
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.map),
                          label: const Text('View on Map'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ScrollController scrollController,
    PlaceModel place,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 20.h),
              children: [
                // Hero Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: place.thumbnailUrl,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 180.h,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 180.h,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Name
                Text(
                  place.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Category & Rating
                Row(
                  children: [
                    Chip(
                      label: Text(
                        PlaceCategory.fromCategoryId(place.categoryId).label,
                        style: context.textTheme.labelMedium,
                      ),
                      backgroundColor: context.colorTheme.primaryContainer
                          .withValues(alpha: 0.2),
                      side: BorderSide.none,
                    ),
                    const Spacer(),
                    if (place.rating != null) ...[
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      SizedBox(width: 4.w),
                      Text(
                        place.rating.toString(),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 16.h),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: context.colorTheme.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        place.location.address,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Description
                if (place.description != null && place.description!.isNotEmpty)
                  Text(
                    place.description!,
                    style: context.textTheme.bodyMedium,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: FilledButton.icon(
                    onPressed: () async {
                      final locationService = sl<LocationService>();
                      final position = await locationService
                          .getCurrentLocation();
                      if (position != null && context.mounted) {
                        context.read<MapCubit>().navigateToPlace(
                          place,
                          Position(position.longitude, position.latitude),
                        );
                        context.read<MapCubit>().dismissBottomSheet();
                      }
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Navigate Here'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFewImages(List<String> photoUrls) {
  return Row(
    children: photoUrls.map((url) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppCachedImage(
              imageUrl: url,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildImageList(
  List<String> photoUrls,
  ScrollController scrollController,
) {
  return ListView.builder(
    controller: scrollController,
    scrollDirection: Axis.horizontal,
    itemCount: photoUrls.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: AppCachedImage(
            imageUrl: photoUrls[index],
            width: 90.w,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
