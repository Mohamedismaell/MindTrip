import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomePopularDestinations extends StatelessWidget {
  const HomePopularDestinations({
    super.key,
    required this.destinations,
  });

  final List<HomeSpotlight> destinations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        separatorBuilder: (_, _) => SizedBox(width: 18.w),
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return Container(
            width: 260.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: destination.imageUrl),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.04),
                          Colors.black.withOpacity(0.52),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.pureWhite,
                              ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 14.sp,
                              color: AppColors.pureWhite.withOpacity(0.86),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              destination.location,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.pureWhite.withOpacity(0.86),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
