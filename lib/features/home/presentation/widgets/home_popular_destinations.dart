import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomePopularDestinations extends StatelessWidget {
  const HomePopularDestinations({super.key, required this.destinations});

  final List<HomeSpotlight> destinations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 198.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,

        itemBuilder: (context, index) {
          final destination = destinations[index];
          return Row(
            children: [
              Container(
                width: 289.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
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
                              Colors.black.withValues(alpha: 0.3),
                              const Color.fromARGB(0, 0, 0, 0),
                            ],
                          ),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(color: Colors.transparent),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 20.w,
                          left: 20.w,
                          top: 30.h,
                          bottom: 20.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      destination.title,
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.pureWhite,
                                          ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      destination.location,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                            color: AppColors.primaryLightGray,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                      color: AppColors.pureWhite.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Icon(
                                        Icons.heart_broken,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      destination.title,
                                      style: context.textTheme.titleMedium
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
                                          color: AppColors.pureWhite
                                              .withOpacity(0.86),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          destination.location,
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                fontSize: 12.sp,
                                                color: AppColors.pureWhite
                                                    .withOpacity(0.86),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                      color: AppColors.pureWhite.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Icon(
                                        Icons.heart_broken,
                                        size: 24.sp,
                                      ),
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
                ),
              ),
              SizedBox(width: 24.w),
            ],
          );
        },
      ),
    );
  }
}
