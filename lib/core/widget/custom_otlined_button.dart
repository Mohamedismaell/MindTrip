import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class CustomOtlinedButton extends StatelessWidget {
  const CustomOtlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colorTheme.error, width: 1),
          foregroundColor: context.colorTheme.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        icon: Icon(icon, size: 24.sp),
        label: Text(
          text,
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorTheme.error,
          ),
        ),
      ),
    );
  }
}
