import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class GeneratingDialog extends StatelessWidget {
  const GeneratingDialog({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 46.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60.w,
                  height: 60.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 5.w,
                    color: context.colorTheme.primary,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  title,
                  style: AppTextStyles.h6Bold.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  textAlign: TextAlign.center,
                  description,
                  style: AppTextStyles.h7Regular.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
