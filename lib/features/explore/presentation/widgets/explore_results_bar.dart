import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreResultsBar extends StatelessWidget {
  const ExploreResultsBar({
    super.key,
    required this.resultCount,
    required this.onFilterTap,
    required this.onSortTap,
  });

  final int resultCount;
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          // Result count
          Expanded(
            child: Text(
              '$resultCount results found',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colorTheme.onSurface,
              ),
            ),
          ),

          // Filter button
          _ActionChip(
            icon: Icons.tune_rounded,
            label: 'Filter',
            onTap: onFilterTap,
          ),
          SizedBox(width: 10.w),

          // Sort button
          _ActionChip(
            icon: Icons.swap_vert_rounded,
            label: 'Sort',
            onTap: onSortTap,
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: context.colorTheme.outline.withOpacity(0.4),
            width: 0.8,
          ),
          color: context.colorTheme.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp, color: AppColors.darkGray2),
            SizedBox(width: 6.w),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
