import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Label
        Text(
          label,
          style: AppTextStyles.h10SemiBold.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),

        //! Value container (read-only, matching editable style)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.colorTheme.outline.withValues(alpha: 0.25),
            ),
          ),
          child: Text(
            value,
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
