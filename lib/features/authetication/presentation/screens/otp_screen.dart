import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_headline.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpVerificationStatusListener(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthHeadline(
                  firstTitle: AppStrings.verifyTitle,
                  secondTitle: AppStrings.yourTitle,
                  thirdTitle: AppStrings.emailTitle,
                ),
                SizedBox(height: 20.h),
                SvgPicture.asset(AppAssets.otpSvg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    AppStrings.enterOtp,
                    style: context.textTheme.bodyLarge,
                  ),
                ),

                SizedBox(height: 34.h),
                const OtpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
