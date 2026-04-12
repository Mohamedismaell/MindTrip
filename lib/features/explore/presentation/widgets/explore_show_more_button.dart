import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreShowMoreButton extends StatelessWidget {
  const ExploreShowMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show More outlined button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                border: Border.all(
                  color: AppColors.primaryBlue,
                  width: 1.2,
                ),
              ),
              child: Text(
                'Show More',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Map icon button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.blueLightGradient,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.map_outlined,
                size: 22.sp,
                color: AppColors.pureWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
