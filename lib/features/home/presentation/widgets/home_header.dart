import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.profileImageUrl});

  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppCachedImage(
            imageUrl: profileImageUrl,
            width: 47.w,
            height: 47.w,
          ),
        ),
        SizedBox(width: 13.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Todo replace with real user name
              Text(
                'HI, Laila',
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  //* You may give it exact size idk
                  SvgPicture.asset(HomeAssets.locationIcon),
                  // Icon(
                  //   Icons.location_on_rounded,
                  //   size: 16.sp,
                  //   color: context.colorTheme.outline,
                  // ),
                  SizedBox(width: 6.w),
                  Text(
                    'Cairo, Egypt',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: context.colorTheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        _HeaderAction(iconPath: HomeAssets.notificaitonIcon, onTap: () {}),
        SizedBox(width: 10.w),
        _HeaderAction(iconPath: HomeAssets.drawerIcon, onTap: () {}),
      ],
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // borderRadius: BorderRadius.circular(24.r),
      child: Container(
        width: 47.w,
        height: 47.h,
        decoration: BoxDecoration(
          color: AppColors.primaryLightGray,
          borderRadius: BorderRadius.circular(23.5.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: SvgPicture.asset(iconPath),
        ),
        // Icon(icon, size: 24.sp, color: context.colorTheme.onSurface),
      ),
    );
  }
}
