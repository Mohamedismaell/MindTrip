import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          // Search field
          Expanded(
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: context.colorTheme.surface,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: context.colorTheme.outline.withOpacity(0.45),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20.sp,
                    color: context.colorTheme.outline,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Destinations, trips, activities...',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        color: context.colorTheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Voice / mic button
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.blueLightGradient,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.mic_rounded,
              size: 22.sp,
              color: AppColors.pureWhite,
            ),
          ),
        ],
      ),
    );
  }
}
