import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomeRecommendedGrid extends StatelessWidget {
  const HomeRecommendedGrid({
    super.key,
    required this.destinations,
  });

  final List<HomeDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 14.w,
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
                    AppCachedImage(imageUrl: destination.imageUrl),
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          destination.priceTag,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              destination.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colorTheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 13.sp,
                  color: context.colorTheme.outline,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    destination.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      color: context.colorTheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
