import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning, Laila',
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: context.textTheme.headlineMedium,
                  children: [
                    const TextSpan(text: 'Where do you\nwant to '),
                    TextSpan(
                      text: 'explore?',
                      style: AppTextStyles.h5Bold.copyWith(
                        color: context.colorTheme.primary,
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }
}
