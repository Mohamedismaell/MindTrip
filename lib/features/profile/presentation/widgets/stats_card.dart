import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key, required this.stats});

  final List<ProfileStatData> stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.5.w),
      child: Container(
        height: 63.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: context.colorTheme.outline),
        ),
        child: Row(
          children: List.generate(stats.length, (index) {
            final stat = stats[index];
            return Expanded(
              child: Row(
                children: [
                  if (index > 0)
                    VerticalDivider(width: 1, color: AppColors.mediumLightGray),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stat.value,
                          style: AppTextStyles.h8Bold.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                        Text(
                          stat.label,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColors.mediumLightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
