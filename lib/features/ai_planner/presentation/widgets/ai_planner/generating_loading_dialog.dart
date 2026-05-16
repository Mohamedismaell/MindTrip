import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

//Todo Edit UI later
class GeneratingDialog extends StatelessWidget {
  const GeneratingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(32.r),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: context.colorTheme.primary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                '✨ Building your trip...',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Mindy is crafting the perfect itinerary just for you.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
