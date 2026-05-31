import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/location/cubit/location_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/core/widget/favorite_place_button.dart';

import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

class ExplorePlaceCard extends StatelessWidget {
  const ExplorePlaceCard({
    super.key,
    required this.place,
    required this.hasBadge,
  });

  final PlaceModel place;
  final bool hasBadge;
  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: () {
        context.push(
          '${AppRoutes.placeDetails}?placeId=${place.id}',
          extra: place,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(15.r),
          //Todo: Check the shadow later
          boxShadow: [AppShadows.tourPackagesCard],
          border: Border.all(color: context.colorTheme.outline, width: 0.5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Image section
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    //Todod: Handle no image later
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.r),
                        topRight: Radius.circular(60.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                      child: AppCachedImage(
                        imagePath: place.imageUrls?.first ?? '',
                      ),
                    ),

                    // Badge
                    if (place.badge != PlaceBadge.none && hasBadge)
                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: _BadgeChip(badge: place.badge),
                      ),
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: FavoriteButton(placeId: place.id),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              _buildCardInfo(context, place),
            ],
          ),
        ),
      ),
    );
  }
}

//  Badge Chip
class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final PlaceBadge badge;

  @override
  Widget build(BuildContext context) {
    final (String label, Color color) = switch (badge) {
      //! change the colors later
      PlaceBadge.topRated => ('Top Rated', AppColors.customgreeen),
      PlaceBadge.popular => ('Popular', AppColors.customYellow),
      PlaceBadge.trending => ('Trending', AppColors.primaryBlue),
      PlaceBadge.aiCrafted => ('AI Crafted', AppColors.primaryLightBlue1),
      PlaceBadge.none => ('', Colors.transparent),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: AppColors.pureWhite,
        ),
      ),
    );
  }
}

Widget _buildHotelInfo(BuildContext context, PlaceModel place) {
  return Expanded(
    flex: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          place.name,
          style: AppTextStyles.h8SemiBold.copyWith(
            color: context.colorTheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),

        // Location + price
        Row(
          children: [
            Expanded(
              child: Text(
                place.location.address,
                style: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.outline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: BlocBuilder<LocationCubit, LocationState>(
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
            ),
          ],
        ),
        SizedBox(height: 10.h),
        place.price != null
            ? CustomHeadLine(
                firstTitle: '\$${place.price!.toStringAsFixed(0)}',
                secondTitle: '  /night',

                firstStyle: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                secondStyle: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.outline,
                ),
              )
            : RatingStars(
                rating: place.rating,
                size: 18.sp,
                showText: true,
                style: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
      ],
    ),
  );
}

//restaurant and cafe and activities
Widget _buildRestaurantInfo(BuildContext context, PlaceModel place) {
  return Expanded(
    flex: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          place.name,
          style: AppTextStyles.h8SemiBold.copyWith(
            color: context.colorTheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),

        RatingStars(
          rating: place.rating,
          size: 18.sp,
          showText: true,
          style: AppTextStyles.h9Medium.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SizedBox(
              width: 18.w,
              height: 18.h,
              child: SvgPicture.asset(
                HomeAssets.locationIcon,
                colorFilter: ColorFilter.mode(
                  context.colorTheme.onSurfaceVariant,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 4.w),

            Expanded(
              child: Text(
                '${place.location.address} / Egypt',
                style: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCardInfo(BuildContext context, PlaceModel place) {
  switch (place.category) {
    case PlaceCategory.hotel:
      return _buildHotelInfo(context, place);
    case PlaceCategory.restaurant || PlaceCategory.cafe:
      return _buildRestaurantInfo(context, place);
    case PlaceCategory.activity:
      return _buildRestaurantInfo(context, place);
    default:
      return _buildRestaurantInfo(context, place);
  }
}
