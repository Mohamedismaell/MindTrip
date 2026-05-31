import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  const PlaceDetailsTripButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 222.w,
        height: 52.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.35),
                blurRadius: 13,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              // Connected when the trip builder flow exposes an add-place action.
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.pureWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.r),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.r),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.primaryLightBlue2],
                ),
              ),
              child: Center(
                child: Text(
                  'Add to your trip',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
