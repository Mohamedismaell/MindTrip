import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class FloatMapButton extends StatelessWidget {
  const FloatMapButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 65.w,
        height: 65.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [AppShadows.floatMapButton],
          // gradient: AppColors.blueLightGradient,
          border: Border.all(
            color: context.colorTheme.primary,
            style: BorderStyle.solid,
            width: 2.5,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.map_outlined,
          size: 32.sp,
          color: context.colorTheme.primary,
        ),
      ),
    );
  }
}
