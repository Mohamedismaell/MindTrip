import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

class TripDetailsTopBar extends StatelessWidget {
  const TripDetailsTopBar({
    super.key,
    required this.onBack,
    required this.onShare,
  });

  final VoidCallback onBack;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 8.h),
        child: SizedBox(
          height: 58.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TapScaleEffect(
                  onTap: onBack,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLightGray,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: context.colorTheme.onSurfaceVariant,
                      size: 28.sp,
                    ),
                  ),
                ),
              ),
              CustomHeadLine(
                firstTitle: 'Trip ',
                secondTitle: 'Details',
                firstStyle: AppTextStyles.h5Bold.copyWith(
                  color: context.colorTheme.primary,
                ),
                secondStyle: AppTextStyles.h5Bold,
              ),
              //Todo Chcek the share
              Align(
                alignment: Alignment.centerRight,
                child: TapScaleEffect(
                  onTap: onShare,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLightGray,
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: context.colorTheme.onSurfaceVariant,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
