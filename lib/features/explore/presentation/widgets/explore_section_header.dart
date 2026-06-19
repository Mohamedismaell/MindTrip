import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class ExploreSectionHeader extends StatelessWidget {
  const ExploreSectionHeader({
    super.key,
    required this.title,
    // this.count,
    this.isActionButton,
    this.onFilterTap,
  });

  final String title;
  // final int? count;
  final VoidCallback? onFilterTap;
  final bool? isActionButton;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.h8SemiBold.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          // if (count != null) ...[
          //   SizedBox(width: 6.w),
          //   Text(
          //     '($count)',
          //     style: AppTextStyles.h8SemiBold.copyWith(
          //       color: context.colorTheme.outline,
          //     ),
          //   ),
          // ],
          Spacer(),
          isActionButton != null
              ? _ActionChip(
                  svgIcon: SvgPicture.asset(ExploreAssets.filterIcon),
                  label: 'Filter',
                  onTap: onFilterTap ?? () {},
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.onTap,
    this.svgIcon,
    this.icon,
  });

  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final Widget? svgIcon;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
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
            svgIcon ??
                Icon(
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
