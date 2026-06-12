import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.actionText,
    this.trailing,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final Widget? trailing;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.h8Bold.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
        const Spacer(),
        if (actionText != null)
          TapScaleEffect(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colorTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
