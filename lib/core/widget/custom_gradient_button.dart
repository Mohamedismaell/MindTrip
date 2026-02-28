import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_gradients.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    this.child,
    required this.text,
    this.style,
    this.width,
    this.onTap,
  });
  final Widget? child;
  final String text;
  final TextStyle? style;
  final double? width;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 200.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          // color: Colors.amberAccent,
          gradient: AppGradients.mainBlueGradient,
          boxShadow: [AppShadows.mainElevationButton],
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child:
              child ??
              Text(text, style: style ?? context.textTheme.labelMedium),
        ),
      ),
    );
  }
}
