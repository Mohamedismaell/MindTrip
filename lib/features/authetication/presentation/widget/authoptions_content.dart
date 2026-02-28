import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/authetication/presentation/widget/auth_options_button.dart';
import 'package:mindtrip/features/authetication/presentation/widget/divider_row.dart';

class AuthoptionsContent extends StatelessWidget {
  const AuthoptionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const DividerRow(),
        ),
        SizedBox(height: 28.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              AuthOptionsButton(
                icon: 'assets/icons/devicon_google.svg',
                text: 'Google',
              ),
              SizedBox(width: 16.w),
              AuthOptionsButton(
                icon: 'assets/icons/icon-park_facebook.svg',
                text: 'Facebook',
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        CustomHeadLine(
          firstTitle: 'Already have an account? ',
          secondTitle: 'Sign In',
          firstStyle: context.textTheme.bodyLarge!.copyWith(
            color: context.colorTheme.outline,
          ),
          secondStyle: context.textTheme.bodyLarge!.copyWith(
            color: context.colorTheme.primary,
          ),
        ),
      ],
    );
  }
}
