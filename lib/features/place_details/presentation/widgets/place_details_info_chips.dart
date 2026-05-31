import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsInfoChips extends StatelessWidget {
  final PlaceModel place;
  
  const PlaceDetailsInfoChips({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ChipItem(
            icon: Icons.timer_outlined,
            title: 'Duration',
            subtitle: '1-2 Hours', // Placeholder logic since we don't have duration in model yet
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _ChipItem(
            icon: Icons.attach_money_outlined,
            title: 'Budget',
            subtitle: place.price != null ? '\$${place.price?.toStringAsFixed(0)}' : 'Free',
          ),
        ),
      ],
    );
  }
}

class _ChipItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ChipItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colorTheme.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.darkGray2,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorTheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
