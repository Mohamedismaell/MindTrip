import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.color,
    this.isLoading,
    this.textStyle,
    this.actionIcon,
    this.padding,
    this.backGroundColor,
    // this.svgIcon,
  });
  final String text;
  final IconData? icon;
  final IconData? actionIcon;
  // final String? svgIcon;
  final VoidCallback? onPressed;
  final Color? color;
  final bool? isLoading;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor;
  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? context.colorTheme.error;
    final isDisabled = onPressed == null
        ? context.colorTheme.outline
        : buttonColor;
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 14.r, horizontal: 5.r),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isLoading == true ? buttonColor : isDisabled,
          width: 1.6,
        ),
      ),
      child: TapScaleEffect(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        enableOverlay: false,
        onTap: onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              isLoading == true
                  ? SizedBox(
                      key: const ValueKey('loader'),
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.sp,
                        color: buttonColor,
                      ),
                    )
                  : Opacity(
                      opacity: isLoading == true ? 0 : 1,
                      child: Row(
                        key: const ValueKey('content'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(icon, size: 20.sp, color: buttonColor),
                            SizedBox(width: 8.w),
                          ],
                          Row(
                            children: [
                              Text(
                                text,
                                style:
                                    textStyle ??
                                    context.textTheme.labelMedium?.copyWith(
                                      color: isLoading == true
                                          ? buttonColor
                                          : isDisabled,
                                    ),
                              ),
                              SizedBox(width: 5.w),
                              if (actionIcon != null)
                                Icon(
                                  actionIcon,
                                  size: 20.sp,
                                  color: isLoading == true
                                      ? buttonColor
                                      : isDisabled,
                                ),
                              // if (svgIcon != null)
                              //   SvgPicture.asset(svgIcon!, height: 20.sp),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
