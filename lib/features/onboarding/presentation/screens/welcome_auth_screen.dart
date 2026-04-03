import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/welcome_image.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WelcomeImage(),
              CustomGradientButton(
                width: double.infinity,
                text: AppStrings.createAccount,
                onTap: () => context.push(AppRoutes.signup),
              ),
              SizedBox(height: 33.h),
              CustomOtlinedButton(
                onPressed: () => context.push(AppRoutes.login),
                text: AppStrings.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
