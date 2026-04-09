import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_headline.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/forget_password_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpRequestStatusListener(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthHeadline(
                  firstTitle: AppStrings.forgetTitle,
                  secondTitle: AppStrings.passwordTitle,
                ),
                SizedBox(height: 20.h),
                SvgPicture.asset(AppAssets.emailCampaignSvg),
                Text(
                  textAlign: TextAlign.left,
                  AppStrings.enterRegisteredEmail,
                  style: AppTextStyles.h7SemiBold,
                ),
                Text(
                  textAlign: TextAlign.left,
                  AppStrings.sendVerificationCode,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
                SizedBox(height: 32.h),
                const ForgetPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
