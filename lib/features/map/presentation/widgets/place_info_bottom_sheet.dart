import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' show Position;
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/domain/entities/place_category.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  const PlaceInfoBottomSheet({super.key});

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) {
        return previous.selectedPlace != current.selectedPlace ||
            previous.isBottomSheetVisible != current.isBottomSheetVisible;
      },
      builder: (context, state) {
        final isVisible = state.isBottomSheetVisible;
        final place = state.selectedPlace;

        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent <= 0.1 && isVisible) {
              context.read<MapCubit>().dismissBottomSheet();
            }
            return false;
          },
          child: DraggableScrollableSheet(
            initialChildSize: isVisible ? 0.45 : 0.0,
            minChildSize: 0.0,
            maxChildSize: 0.8,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: place == null
                    ? const SizedBox()
                    : _buildContent(context, scrollController, place),
              );
            },
          ),
        );
      },
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
                // Hero Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: place.thumbnailUrl ?? '',
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
                          .withOpacity(0.2),
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
                        place.location.address ?? 'Address not available',
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
