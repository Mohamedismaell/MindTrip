import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class EditableInfoRow extends StatelessWidget {
  const EditableInfoRow({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            label,
            style: AppTextStyles.h9Bold.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.onSurfaceVariant.withOpacity(0.5),
              ),
              //* Default Border
              border: InputBorder.none,
              //* Enabled
              enabledBorder: InputBorder.none,
              //* Focused
              focusedBorder: InputBorder.none,
              //* Error
              errorBorder: InputBorder.none,
              //* Focused Error
              focusedErrorBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4.h),
            ),
          ),
        ),
      ],
    );
  }
}
