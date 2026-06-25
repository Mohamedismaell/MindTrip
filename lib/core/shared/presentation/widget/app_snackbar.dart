import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

enum AppSnackBarType { success, error }

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required AppSnackBarType type,
  }) {
    final isSuccess = type == AppSnackBarType.success;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(16.w),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 8),
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ],
            border: Border.all(
              color: isSuccess ? AppColors.successGreen : AppColors.errorRed,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSuccess
                      ? AppColors.successGreen
                      : AppColors.errorRed,
                ),
                child: Icon(
                  isSuccess ? Icons.check_rounded : Icons.close_rounded,
                  size: 14.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.h9Medium.copyWith(
                    color: context.colorTheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // SnackBar(
      //   behavior: SnackBarBehavior.floating,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(40.r),
      //   ),

      //   content: Row(
      //     children: [
      //       Container(
      //         height: 30.h,
      //         width: 30.w,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: isSuccess
      //               ? AppColors.successDarkGreen
      //               : AppColors.errorDarkRed,
      //         ),
      //         child: Icon(
      //           isSuccess ? Icons.done : Icons.close,
      //           color: context.colorTheme.onPrimary,
      //         ),
      //       ),
      //       SizedBox(width: 12.w),
      //       Expanded(
      //         child: Text(
      //           message,
      //           style: AppTextStyles.h8SemiBold.copyWith(
      //             color: isSuccess
      //                 ? AppColors.successLight
      //                 : AppColors.errorLight,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   backgroundColor:
      //       (isSuccess ? AppColors.successGreen : AppColors.errorRed)
      //           .withValues(alpha: 0.8),
      // ),
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, type: AppSnackBarType.success);
  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, type: AppSnackBarType.error);
  }
}
