import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class FlowButton extends StatelessWidget {
  const FlowButton({
    super.key,
    required this.enabled,
    required this.text,
    required this.onTap,
  });

  final bool enabled;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final decoration = enabled
        ? BoxDecoration(
            gradient: AppColors.blueLightGradient,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [AppShadows.mainElevationButton],
          )
        : BoxDecoration(
            color: context.colorTheme.outline.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(50.r),
          );

    return Center(
      child: SizedBox(
        width: 283.w,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            height: 52.h,
            decoration: decoration,
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.h7Bold.copyWith(
                  color: enabled
                      ? context.colorTheme.onPrimary
                      : context.colorTheme.outline,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
