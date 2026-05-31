import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsInfoChips extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsInfoChips({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _OutlinedInfoChip(
            icon: Icons.timer_outlined,
            label: '2-3 Hours',
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _OutlinedInfoChip(
            icon: Icons.savings_outlined,
            label: place.price == null || place.price == 0
                ? 'Free entry'
                : 'Moderate budget',
          ),
        ),
      ],
    );
  }
}

class _OutlinedInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OutlinedInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(
          color: AppColors.mediumLightGray.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.r, color: AppColors.darkGray2),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGray1,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
