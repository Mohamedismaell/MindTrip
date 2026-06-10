import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';

enum AppDialogType { info, success, error, permission, confirm }

class AppDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? description,
    required String primaryText,
    String? secondaryText,
    required VoidCallback onPrimary,
    VoidCallback? onSecondary,
    bool? showIcon,
    IconData icon = Icons.info,
    Color? iconColor,
    TextStyle? titleStyle,
    Widget? child,
    Widget Function(BuildContext, Widget)? providerBuilder,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dialog",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),

      pageBuilder: (dialogContext, _, _) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Colors.black12),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  showIcon == false
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              (iconColor ?? AppColors.primaryLightBlue1)
                                  .withValues(alpha: 0.2),
                          child: Icon(
                            icon,
                            color: iconColor ?? context.colorTheme.primary,
                            size: 32.sp,
                          ),
                        ),
                  SizedBox(height: 16.h),
                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle ?? context.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8.h),

                  // Description
                  description == null
                      ? child ?? const SizedBox.shrink()
                      : Text(
                          description,
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        ),
                  SizedBox(height: 20.h),

                  // Action Buttons
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmall = constraints.maxWidth < 320;
                      if (isSmall) {
                        return Column(
                          children: [
                            //! PRIMARY BUTTON
                            SizedBox(
                              width: double.infinity,
                              child: CustomGradientButton(
                                onTap: () {
                                  Navigator.pop(dialogContext, true);
                                  onPrimary();
                                },
                                text: primaryText,
                              ),
                            ),

                            //! SECONDARY BUTTON
                            if (secondaryText != null) ...[
                              SizedBox(height: 12.h),

                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext, false);
                                    onSecondary?.call();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: context.colorTheme.error,
                                      width: 1.5,
                                    ),

                                    padding: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                    ),
                                  ),
                                  child: Text(
                                    secondaryText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: context.colorTheme.error,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      }
                      return Row(
                        children: [
                          if (secondaryText != null) ...[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext, false);

                                  onSecondary?.call();
                                },

                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: context.colorTheme.error,
                                    width: 1.5,
                                  ),

                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),

                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    secondaryText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: context.colorTheme.error,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 12.w),
                          ],
                          Expanded(
                            child: CustomGradientButton(
                              onTap: () {
                                Navigator.pop(dialogContext, true);

                                onPrimary();
                              },

                              text: primaryText,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Future<void> showLoading({
    required BuildContext context,
    String title = 'Loading',
    String? description,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Loading',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (dialogContext, _, _) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Colors.black12),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 36.w,
                    height: 36.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: context.colorTheme.primary,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall,
                  ),

                  if (description != null) ...[
                    SizedBox(height: 8.h),

                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static void hideLoading(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}
