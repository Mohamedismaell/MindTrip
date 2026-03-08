import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_options_button.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/divider_row.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Widget
///
/// [AuthoptionsContent] renders the "or with" divider, social login buttons,
/// and the toggle prompt ("Already have an account? Sign In" / vice versa).
///
/// Made configurable via [promptText], [actionText] and [onActionTap] so both
/// the Sign In and Sign Up screens can reuse it.
/// ──────────────────────────────────────────────────────────────────────────────
class AuthoptionsContent extends StatelessWidget {
  /// Text before the action link, e.g. "Already have an account? ".
  final String promptText;

  /// The tappable action label, e.g. "Sign In".
  final String actionText;

  /// Called when the action text is tapped.
  final VoidCallback? onActionTap;

  const AuthoptionsContent({
    super.key,
    this.promptText = 'Already have an account? ',
    this.actionText = 'Sign In',
    this.onActionTap,
  });

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
        GestureDetector(
          onTap: onActionTap,
          child: CustomHeadLine(
            firstTitle: promptText,
            secondTitle: actionText,
            firstStyle: context.textTheme.bodyLarge!.copyWith(
              color: context.colorTheme.outline,
            ),
            secondStyle: context.textTheme.bodyLarge!.copyWith(
              color: context.colorTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
