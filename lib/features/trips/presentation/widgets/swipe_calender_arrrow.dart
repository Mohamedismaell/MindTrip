import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class SwipeCalenderArrrow extends StatelessWidget {
  const SwipeCalenderArrrow({
    super.key,
    required this.onTap,
    required this.icon,
  });
  final VoidCallback onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      enableOverlay: false,

      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLightGray,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24.sp,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
