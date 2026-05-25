import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_actions.dart';
import 'package:mindtrip/features/map/presentation/widgets/place_images.dart';

class PlaceTab extends StatelessWidget {
  const PlaceTab({
    super.key,
    this.place,
    this.googlePlace,
    this.photoUrls,
    required this.imagesScrollController,
    this.dragController,
    this.heroTag,
  });
  final PlaceModel? place;
  final GooglePlaceEntity? googlePlace;
  final List<String>? photoUrls;
  final ScrollController imagesScrollController;
  final DraggableScrollableController? dragController;
  final String? heroTag;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (photoUrls != null && photoUrls.isNotEmpty)
          PlaceImages(
            photoUrls: photoUrls,
            scrollController: imagesScrollController,
            heroTag: heroTag,
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
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (place.userRatingCount != null && place.userRatingCount! > 0)
              Text(
                '${place.userRatingCount} Reviews ',
                style: AppTextStyles.h8SemiBold,
              ),

            // Opening Hours
            if (place.openingHours != null)
              Text(
                place.openingHours!.openNow == true ? 'Open Now' : 'Closed Now',
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: place.openingHours!.openNow == true
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
        // Description
        if (place.editorialSummary != null)
          Text(place.editorialSummary!, style: context.textTheme.bodyMedium),

        SizedBox(height: 24.h),
        PlaceActions(
          latitude: place.latitude,
          longitude: place.longitude,
          dragController: dragController,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PlaceModel place) {
    final photoUrls = place.imageUrls;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      child: Column(
        children: [
          if (photoUrls != null)
            PlaceImages(
              photoUrls: photoUrls,
              scrollController: imagesScrollController,
              heroTag: heroTag,
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
            dragController: dragController,
          ),
        ],
      ),
    );
  }
}
