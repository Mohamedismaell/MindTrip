import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class EditBioSection extends StatelessWidget {
  const EditBioSection({super.key, required this.controller, this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'BIO',
              style: AppTextStyles.h8Bold.copyWith(color: AppColors.pureBlack),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.edit, size: 19.sp, color: context.colorTheme.primary),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          width: double.infinity,
          height: 160.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.primaryLightGray,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: null,
            maxLines: null,
            expands: true,
            maxLength: 220,
            style: AppTextStyles.h7Medium.copyWith(
              color: context.colorTheme.onSurfaceVariant,
              height: 1.45,
            ),
            decoration: InputDecoration(
              hintText: 'Chasing sunrises, collecting stories.',
              hintStyle: AppTextStyles.h7Medium.copyWith(
                color: context.colorTheme.outline,
                height: 1.45,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}
