import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

enum AppSnackBarType { success, error }

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required AppSnackBarType type,
  }) {
    final isSuccess = type == AppSnackBarType.success;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.r),
        ),
        content: Row(
          children: [
            Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSuccess
                    ? AppColors.successDarkGreen
                    : AppColors.errorDarkRed,
              ),
              child: Icon(
                isSuccess ? Icons.done : Icons.close,
                color: context.colorTheme.onPrimary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: isSuccess
                      ? AppColors.successLight
                      : AppColors.errorLight,
                ),
              ),
            ),
          ],
        ),
        backgroundColor:
            (isSuccess ? AppColors.successGreen : AppColors.errorRed)
                .withValues(alpha: 0.8),
      ),
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    show(context, message: message, type: AppSnackBarType.success);
  }

  static void showError(BuildContext context, {required String message}) {
    show(context, message: message, type: AppSnackBarType.error);
  }
}
