import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';

class ExplorePlaceCard extends StatelessWidget {
  const ExplorePlaceCard({super.key, required this.place});

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    double rating = (place.rating ?? 0).clamp(0, 5);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [AppShadows.tourPackagesCard],
        border: Border.all(color: context.colorTheme.outline, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Image section
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: place.thumbnailUrl),

                  // Badge
                  if (place.badge != null &&
                      place.badge != PlaceBadge.none)
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: _BadgeChip(badge: place.badge),
                    ),
                ],
              ),
            ),

            //  Details section
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        Text(
                          place.name,
                          style: context.textTheme.labelLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        // Heart
                        BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, state) {
                            final isFavorite = context.read<FavoriteCubit>().isFavorite(place.id);
                            return GestureDetector(
                              onTap: () {
                                context.read<FavoriteCubit>().toggleFavorite(
                                      placeId: place.id,
                                      isFavorite: !isFavorite,
                                    );
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.pureWhite.withValues(
                                    alpha: 0.85,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: 16.sp,
                                  color: isFavorite
                                      ? Colors.red
                                      : context.colorTheme.onSurface,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    // Stars + rating
                    RatingStars(rating: rating),
                    const Spacer(),

                    // Location + price
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: SvgPicture.asset(
                            HomeAssets.locationIcon,
                            colorFilter: ColorFilter.mode(
                              context.colorTheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            place.location.address,
                            style: context.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //! May change color later
                        Text(
                          place.price != null
                              ? '\$${place.price!.toStringAsFixed(0)}'
                              : '',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: AppColors.customgreeen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
