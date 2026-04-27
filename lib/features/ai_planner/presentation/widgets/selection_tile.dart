import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class SelectionTile extends StatelessWidget {
  const SelectionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 53.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected
                ? context.colorTheme.primary
                : context.colorTheme.outline,
            width: selected ? 1.5.w : 0.4.w,
          ),
          boxShadow: [AppShadows.aiplannerShadow],
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: AppTextStyles.h8Medium.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
      ),
    );
  }
}
