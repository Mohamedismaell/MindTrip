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
    this.isLoading,
    this.color,
  });
  final Widget? child;
  final String text;
  final TextStyle? style;
  final double? width;
  final VoidCallback? onTap;
  final bool? isLoading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final buttonColor = color;
    final isDisabled = onTap == null;
    final disabledColor = isDisabled ? context.colorTheme.outline : buttonColor;
    final disabledBackground = context.colorTheme.onSurface.withValues(
      alpha: 0.12,
    );

    final disabledTextColor = isDisabled
        ? context.colorTheme.onSurface.withValues(alpha: 0.38)
        : buttonColor;
    return Container(
      width: width ?? 200.w,
      decoration: BoxDecoration(
        color: isDisabled ? disabledBackground : null,
        gradient: isDisabled ? null : AppGradients.mainBlueGradient,
        boxShadow: isDisabled ? [] : [AppShadows.mainElevationButton],
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(50.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: isLoading == true
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        color: context.colorTheme.onPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : child ??
                        Text(
                          text,
                          style:
                              style?.copyWith(color: disabledTextColor) ??
                              context.textTheme.labelMedium?.copyWith(
                                color: disabledTextColor,
                              ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
