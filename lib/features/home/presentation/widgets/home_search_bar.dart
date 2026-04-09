import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: context.colorTheme.outline.withOpacity(0.55),
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
                SizedBox(width: 8.w),
                Text(
                  'Search here..',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: context.colorTheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            // color: AppColors.primaryLightGray,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colorTheme.outline.withOpacity(0.45),
              width: 0.8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(HomeAssets.filterIcon),
          ),
          // Icon(
          //   Icons.tune_rounded,
          //   size: 22.sp,
          //   color: context.colorTheme.outline,
          // ),
        ),
      ],
    );
  }
}
