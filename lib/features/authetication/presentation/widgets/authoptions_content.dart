import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_options_button.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/divider_row.dart';

class AuthoptionsContent extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback? onActionTap;

  const AuthoptionsContent({
    super.key,
    this.promptText = 'Already have an account? ',
    this.actionText = 'Sign In',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;
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
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().loginWithGoogle();
                          },
                  ),
                  SizedBox(width: 16.w),
                  AuthOptionsButton(
                    icon: 'assets/icons/icon-park_facebook.svg',
                    text: 'Facebook',
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().loginWithFacebook();
                          },
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promptText,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
                SizedBox(width: 4.w),
                TapScaleEffect(
                  onTap: onActionTap,
                  child: Text(
                    actionText,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
