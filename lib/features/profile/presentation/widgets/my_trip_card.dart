import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
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
        height: 233.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(imageUrl: data.imageUrl, fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 72.h,
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                color: Colors.black.withOpacity(0.22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      data.subtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryLightGray,
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
