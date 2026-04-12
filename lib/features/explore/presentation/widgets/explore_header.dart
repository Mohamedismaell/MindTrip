import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Todo replace with real user name
              Text(
                'Good morning, Laila',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: context.colorTheme.outline,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.menu_rounded,
                  size: 26.sp,
                  color: context.colorTheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: context.colorTheme.onSurface,
              ),
              children: [
                const TextSpan(text: 'Where do you\nwant to '),
                TextSpan(
                  text: 'explore?',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
