import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class MapNavigateAllButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;

  const MapNavigateAllButton({
    super.key,
    required this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.isNotEmpty;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: hasLabel ? 20.w : 0),
        decoration: BoxDecoration(
          color: context.colorTheme.primary,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [AppShadows.mapToolButtons],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.alt_route_rounded,
              color: context.colorTheme.onPrimary,
              size: 22.sp,
            ),
            if (hasLabel) ...[
              SizedBox(width: 10.w),
              Text(
                label!,
                style: AppTextStyles.h9Bold.copyWith(
                  color: context.colorTheme.onPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
