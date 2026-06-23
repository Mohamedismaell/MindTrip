import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';

class CompleteResetPassword extends StatelessWidget {
  const CompleteResetPassword({
    super.key,
    // required this.actionText,
  });
  // final String actionText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.5.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppAssets.completeSvg),
              SizedBox(height: 45.h),
              Text(
                'Congratulations !',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: context.colorTheme.primary,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                AppStrings.passwordResetSuccessfuly,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorTheme.outline,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 45.h),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Text(AppStrings.backToLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
