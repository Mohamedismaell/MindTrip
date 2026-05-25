import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';

class MapActionButton extends StatelessWidget {
  const MapActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.isFilled,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final bool isFilled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isFilled ? color : Colors.white,
            borderRadius: BorderRadius.circular(100.r),
            border: isFilled
                ? null
                : Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.sp, color: isFilled ? Colors.white : color),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.h10Bold.copyWith(
                  color: isFilled ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
