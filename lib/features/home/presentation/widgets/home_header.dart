import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

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
                  Icon(
                    Icons.location_on_rounded,
                    size: 16.sp,
                    color: context.colorTheme.outline,
                  ),
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
        //Todo replace with real icons
        _HeaderAction(icon: Icons.notifications_none_rounded, onTap: () {}),
        SizedBox(width: 10.w),
        _HeaderAction(icon: Icons.menu_rounded, onTap: () {}),
      ],
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        width: 47.w,
        height: 47.w,
        decoration: BoxDecoration(
          color: AppColors.primaryLightGray,
          borderRadius: BorderRadius.circular(23.5.r),
        ),
        child: Icon(icon, size: 24.sp, color: context.colorTheme.onSurface),
      ),
    );
  }
}
