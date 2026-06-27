import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class MapRelocateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;

  const MapRelocateButton({super.key, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      enableOverlay: false,
      onTap: onPressed,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mapToolButtons],
          border: Border.all(
            color: context.colorTheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Icon(
          icon ?? Icons.my_location_rounded,
          color: context.colorTheme.primary,
          size: 28.sp,
        ),
      ),
    );
  }
}
