import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class EditTopBar extends StatelessWidget {
  const EditTopBar({super.key, required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TapScaleEffect(
              enableOverlay: false,
              onTap: onBackTap,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLightGray,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 28.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Text(
            'Edit Profile',
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
