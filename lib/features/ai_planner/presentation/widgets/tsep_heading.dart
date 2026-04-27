import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class StepHeading extends StatelessWidget {
  const StepHeading({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyles.h6Bold.copyWith(
                color: context.colorTheme.onSurface,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(icon, size: 22.sp, color: context.colorTheme.primary),
          ],
        ),
        SizedBox(height: 13.h),
        Text(
          subtitle,
          style: AppTextStyles.h7Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
