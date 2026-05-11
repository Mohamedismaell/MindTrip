import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.h9Bold.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            // color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
