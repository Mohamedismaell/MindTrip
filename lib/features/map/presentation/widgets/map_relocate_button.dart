import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class MapRelocateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MapRelocateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mainElevationButton],
          border: Border.all(
            color: context.colorTheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.my_location_rounded,
          color: context.colorTheme.primary,
          size: 28.sp,
        ),
      ),
    );
  }
}
