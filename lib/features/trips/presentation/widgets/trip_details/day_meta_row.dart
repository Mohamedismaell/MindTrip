import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class DayMetaRow extends StatelessWidget {
  const DayMetaRow({
    super.key,
    required this.placesCount,
    required this.totalDayCost,
  });

  final int placesCount;
  final double totalDayCost;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 10.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _IconText(
          icon: Icons.location_on_outlined,
          text: '$placesCount places',
        ),
        SizedBox(width: 10.w),
        _CostChip(cost: totalDayCost),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20.sp, color: context.colorTheme.outline),
        SizedBox(width: 4.w),
        Text(
          text,
          style: AppTextStyles.h10Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CostChip extends StatelessWidget {
  const _CostChip({required this.cost});

  final double cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        '~${cost.round()} EGP',
        style: AppTextStyles.h10Regular.copyWith(
          color: AppColors.customgreeen2,
        ),
      ),
    );
  }
}
