import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsNearbyPlaces extends StatelessWidget {
  final List<PlaceModel> places;
  final bool isLoading;

  const PlaceDetailsNearbyPlaces({
    super.key,
    required this.places,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 118.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (places.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Places',
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.pureBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 114.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: places.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) =>
                _NearbyPlaceCard(place: places[index]),
          ),
        ),
      ],
    );
  }
}

class _NearbyPlaceCard extends StatelessWidget {
  final PlaceModel place;

  const _NearbyPlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    final image = place.imageUrls?.isNotEmpty == true
        ? place.imageUrls!.first
        : 'assets/images/onboarding/Pyramids.webp';

    return Container(
      width: 126.w,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.mediumLightGray.withValues(alpha: 0.55),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCachedImage(
            imagePath: image,
            width: double.infinity,
            height: 66.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 0),
            child: Text(
              place.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelLarge?.copyWith(
                color: AppColors.darkGray1,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              children: [
                Icon(
                  Icons.directions_car_filled_outlined,
                  size: 13.r,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(width: 4.w),
                Text(
                  '0.4 km',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 12.sp,
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
