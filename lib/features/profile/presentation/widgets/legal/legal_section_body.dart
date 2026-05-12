import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_legal_content.dart';

class LegalSectionBody extends StatelessWidget {
  const LegalSectionBody({super.key, required this.section});

  final ProfileLegalSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: AppTextStyles.h7Bold.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        ...section.items.map((item) => _LegalBullet(text: item)),
      ],
    );
  }
}

class _LegalBullet extends StatelessWidget {
  const _LegalBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 9.h),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: AppColors.mediumLightGray,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
