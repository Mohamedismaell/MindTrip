import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class HomeRecommendedGrid extends StatelessWidget {
  const HomeRecommendedGrid({super.key, required this.destinations});

  final List<PlaceModel> destinations;

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppCachedImage(imageUrl: destination.thumbnailUrl),
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
                            color: AppColors.pureWhite.withOpacity(0.92),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
