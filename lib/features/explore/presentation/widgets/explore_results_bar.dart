import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

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
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
          ),

          // Filter button
          _ActionChip(
            svgIcon: SvgPicture.asset(ExploreAssets.filterIcon),
            label: 'Filter',
            onTap: onFilterTap,
          ),
          SizedBox(width: 10.w),

          // Sort button
          _ActionChip(
            svgIcon: SvgPicture.asset(ExploreAssets.sortIcon),
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
    required this.label,
    required this.onTap,
    this.icon,
    this.svgIcon,
  });

  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final Widget? svgIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
            color: context.colorTheme.onSurfaceVariant,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgIcon != null
                ? svgIcon!
                : Icon(
                    icon,
                    size: 24.sp,
                    color: context.colorTheme.onSurfaceVariant,
                  ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
