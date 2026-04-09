import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel = 'See More',
  });

  final String title;
  final String? subtitle;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorTheme.onSurface,
                ),
              ),
            ),
            Text(
              actionLabel,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: context.colorTheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: 4.h),
          Text(
            subtitle!,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: context.colorTheme.outline,
            ),
          ),
        ],
      ],
    );
  }
}
