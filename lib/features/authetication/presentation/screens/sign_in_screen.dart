import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/app_background.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/sign_in_form.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/authoptions_content.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Screen
///
/// [SignInScreen] is the login page. It wraps the form in an [AuthStatusListener]
/// so that error-snackbar logic is handled declaratively via [BlocListener].
/// Navigation on success is handled by [AppGateCubit] + GoRouter redirect.
/// ──────────────────────────────────────────────────────────────────────────────
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                const CustomHeadLine(firstTitle: 'Sign ', secondTitle: 'In'),
                SizedBox(height: 40.h),
                const SignInForm(),
                SizedBox(height: 24.h),
                AuthoptionsContent(
                  promptText: "Don't have an account? ",
                  actionText: 'Sign Up',
                  onActionTap: () => context.push(AppRoutes.signup),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
