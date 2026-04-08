import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_headline.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStatusListener(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthHeadline(
                  firstTitle: AppStrings.resetTitle,
                  secondTitle: AppStrings.resetePasswordTitle,
                ),
                SizedBox(height: 20.h),

                SvgPicture.asset(AppAssets.resetePasswordSvg),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.resetePasswordDescription,
                  style: context.textTheme.bodyLarge!.copyWith(
                    // color: context.colorTheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 40.h),
                //!Edit
                const ResetPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
