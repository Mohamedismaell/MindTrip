import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';

class CustomCalenderHeader extends StatelessWidget {
  const CustomCalenderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 30.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),

            CustomHeadLine(
              firstTitle: 'My ',
              secondTitle: 'Trips',
              firstStyle: AppTextStyles.h5Bold.copyWith(
                color: context.colorTheme.onSurface,
              ),
              secondStyle: AppTextStyles.h5Bold.copyWith(
                color: context.colorTheme.primary,
              ),
            ),
          ],
        ),

        SizedBox(height: 17.h),

        Text(
          'All your travel dates in one place',
          style: AppTextStyles.h7Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
