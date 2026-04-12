import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key, required this.stats});

  final List<ProfileStatData> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 63.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.mediumLightGray),
      ),
      child: Row(
        children: List.generate(stats.length, (index) {
          final stat = stats[index];
          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: AppColors.primaryLightGray,
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stat.value,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colorTheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        stat.label,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 16.sp,
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
    );
  }
}
