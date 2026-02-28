import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/widget/app_background.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/authetication/presentation/widget/authoptions_content.dart';
import 'package:mindtrip/features/authetication/presentation/widget/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomHeadLine(firstTitle: 'Sign ', secondTitle: 'Up'),
            SizedBox(height: 40.h),
            const SignUpForm(),
            SizedBox(height: 24.h),
            const AuthoptionsContent(),
          ],
        ),
      ),
    );
  }
}
