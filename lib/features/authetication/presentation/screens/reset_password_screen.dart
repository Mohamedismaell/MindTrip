import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/app_background.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/sign_in_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStatusListener(
      child: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomHeadLine(
                  firstTitle: AppStrings.resetTitle,
                  secondTitle: AppStrings.resetePasswordTitle,
                ),
                SizedBox(height: 40.h),
                //!Edit
                const SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
