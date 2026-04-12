import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.actionText,
    this.trailing,
  });

  final String title;
  final String? actionText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.colorTheme.onSurface,
          ),
        ),
        if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
        const Spacer(),
        if (actionText != null)
          Text(
            actionText!,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mediumLightGray,
            ),
          ),
      ],
    );
  }
}
