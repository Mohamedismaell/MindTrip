import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/welcome_image.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
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
                onTap: () {
                  context.read<AppGateCubit>().proceedToAuth();
                  context.go(AppRoutes.signup);
                },
              ),
              SizedBox(height: 33.h),
              SizedBox(
                width: double.infinity,
                child: CustomOtlinedButton(
                  onPressed: () {
                    context.read<AppGateCubit>().proceedToAuth();
                    context.go(AppRoutes.login);
                  },
                  text: AppStrings.login,
                  color: context.colorTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
