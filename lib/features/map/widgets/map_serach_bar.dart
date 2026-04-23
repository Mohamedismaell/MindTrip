import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class MapSerachBar extends StatelessWidget {
  const MapSerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search field
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          decoration: BoxDecoration(
            boxShadow: [AppShadows.mainElevationButton],
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: context.colorTheme.outline.withValues(alpha: 0.45),
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 24.sp,
                color: context.colorTheme.onSurface,
              ),
              SizedBox(width: 10.w),
              Text(
                'Looking for a place ...',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
