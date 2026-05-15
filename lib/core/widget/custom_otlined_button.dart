import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class CustomOtlinedButton extends StatelessWidget {
  const CustomOtlinedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.color,
    this.isLoading,
  });
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? color;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? context.colorTheme.error;
    final isDisabled = onPressed == null
        ? context.colorTheme.outline
        : buttonColor;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isLoading == true ? buttonColor : isDisabled,
          width: 1.8,
        ),
        foregroundColor: isDisabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
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
                          Icon(icon, size: 20.sp),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          text,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: isDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
