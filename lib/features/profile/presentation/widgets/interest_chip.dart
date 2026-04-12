import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({super.key, required this.data});

  final ProfileInterestData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.mediumLightGray),
      ),
      child: Text(
        '${data.emoji} ${data.label}',
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 16.sp,
          color: AppColors.mediumLightGray,
        ),
      ),
    );
  }
}
