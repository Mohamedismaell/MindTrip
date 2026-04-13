import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/favorite_bubble.dart';

class MyTripCard extends StatelessWidget {
  const MyTripCard({super.key, required this.data});

  final ProfileTripData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: SizedBox(
        width: 205.w,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(imageUrl: data.imageUrl, fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: 72.h,
                        padding: EdgeInsets.all(10.w),
                        color: Colors.black.withValues(alpha: 0.22),
                      ),
                    ),
                    Container(
                      height: 72.h,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      alignment: Alignment.centerLeft,
                      color: Colors.black.withValues(alpha: 0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.title,
                            style: AppTextStyles.h8Bold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            data.subtitle,
                            style: AppTextStyles.h9Bold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.primaryLightGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              top: 12.h,
              child: FavoriteBubble(isFavorite: data.isFavorite),
            ),
          ],
        ),
      ),
    );
  }
}
