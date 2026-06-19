import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class AuthHeadline extends StatelessWidget {
  const AuthHeadline({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    this.thirdTitle,
  });

  final String firstTitle;
  final String secondTitle;
  final String? thirdTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TapScaleEffect(
          onTap: () => context.pop(),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryLightGray,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.sp,
              color: context.colorTheme.onSurface,
            ),
          ),
        ),
        // SizedBox(width: 10.w),
        Expanded(
          child: CustomHeadLine(
            firstTitle: firstTitle,
            secondTitle: secondTitle,
            firstStyle: AppTextStyles.h5Bold.copyWith(
              color: context.colorTheme.primary,
            ),
            secondStyle: AppTextStyles.h5Bold.copyWith(
              color: context.colorTheme.onSurface,
            ),
            thirdTitle: thirdTitle,
          ),
        ),
      ],
    );
  }
}
