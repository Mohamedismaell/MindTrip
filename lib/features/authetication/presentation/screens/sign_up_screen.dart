import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/app_background.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/sign_up_form.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/authoptions_content.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Screen
///
/// [SignUpScreen] is the registration page. Like [SignInScreen], it wraps
/// everything in an [AuthStatusListener] for declarative side-effect handling.
/// Navigation on success is handled by [AppGateCubit] + GoRouter redirect.
/// ──────────────────────────────────────────────────────────────────────────────
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpRequestStatusListener(
      child: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomHeadLine(
                    firstTitle: AppStrings.signTitle,
                    secondTitle: AppStrings.upTitle),
                SizedBox(height: 40.h),
                const SignUpForm(),
                SizedBox(height: 24.h),
                AuthoptionsContent(
                  promptText: AppStrings.alreadyHaveAccount,
                  actionText: AppStrings.signIn,
                  onActionTap: () => context.pushReplacement(AppRoutes.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
