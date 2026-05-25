import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';

class MapMarkRelcoaitonButton extends StatelessWidget {
  const MapMarkRelcoaitonButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mapToolButtons],
        ),
        child: Icon(
          Icons.fit_screen_rounded,
          color: context.colorTheme.primary,
          size: 28.sp,
        ),
      ),
    );
  }
}
