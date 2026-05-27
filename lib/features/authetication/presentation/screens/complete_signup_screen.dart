import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';
import 'package:mindtrip/features/authetication/presentation/widgets/auth_status_listener.dart';

class CompleteSignUpScreen extends StatelessWidget {
  const CompleteSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInStatusListener(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.5.w),
          child: Center(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.completeSvg),
                    SizedBox(height: 45.h),
                    Text(
                      'Congratulations !',
                      style: context.textTheme.headlineLarge!.copyWith(
                        color: context.colorTheme.primary,
                        fontSize: 32.sp,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      AppStrings.emailVerified,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                    SizedBox(height: 45.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomOtlinedButton(
                        onPressed: isLoading ? null : () => context.go(AppRoutes.login),
                        text: isLoading ? "Logging in..." : AppStrings.backToLogin,
                        textStyle: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorTheme.primary,
                        ),
                        color: context.colorTheme.primary,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
