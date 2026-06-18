import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/favorite_place_button.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecommendedplacesGrid extends StatelessWidget {
  final List<PlaceEntity> destinations;
  final bool isLoading;

  const RecommendedplacesGrid({
    super.key,
    required this.destinations,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: destinations.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 28.h,
        crossAxisSpacing: 37.w,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return Skeletonizer(
          enabled: isLoading,
          child: TapScaleEffect(
            onTap: () {
              if (isLoading) return;
              context.push(
                '${AppRoutes.placeDetails}?placeId=${destination.id}&heroTag=rec_${destination.id}',
                extra: destination,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'rec_${destination.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppCachedImage(
                            imagePath: destination.imageUrls?.first ?? '',
                          ),
                          Positioned(
                            top: 10.h,
                            left: 10.w,
                            child: FavoriteButton(placeId: destination.id),
                          ),
                          if (destination.price != null)
                            Positioned(
                              top: 6.h,
                              right: 10.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pureWhite.withValues(
                                    alpha: 0.92,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  destination.price.toString(),
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    destination.name,
                    style: AppTextStyles.h9Bold.copyWith(
                      color: context.colorTheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(HomeAssets.locationIcon),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          destination.location.address,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorTheme.outline,
                          ),

                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
