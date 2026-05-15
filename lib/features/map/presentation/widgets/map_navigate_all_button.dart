import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';

class MapNavigateAllButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MapNavigateAllButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.colorTheme.primary,
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mainElevationButton],
          border: Border.all(
            color: context.colorTheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.alt_route_rounded,
          color: context.colorTheme.onPrimary,
          size: 28.sp,
        ),
      ),
    );
  }
}
