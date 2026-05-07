import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.state,
  });
  final PageController pageController;
  final OnboardingState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothPageIndicator(
          controller: pageController,
          count: 4,
          effect: SwapEffect(
            dotWidth: 30.w,
            dotHeight: 7.h,
            spacing: 8.w,
            dotColor: AppColors.primaryLightBlue1,
            activeDotColor: context.colorTheme.primary,
          ),
          // onDotClicked: (index) {},
        ),
        SizedBox(height: 72.h),
        BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final isLastpage = state.isLastPage;
            return Column(
              children: [
                CustomGradientButton(
                  text: isLastpage ? AppStrings.getStarted : AppStrings.next,
                  onTap: () async {
                    if (isLastpage) {
                      await context.read<OnboardingCubit>().finishOnboarding();
                      if (context.mounted) {
                        context.read<AppGateCubit>().start();
                      }
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutCubic,
                      );
                    }
                  },
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: !isLastpage,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    onPressed: () async {
                      await context.read<OnboardingCubit>().finishOnboarding();
                      if (context.mounted) {
                        context.read<AppGateCubit>().start();
                      }
                    },
                    child: Text(
                      AppStrings.skip,
                      style: AppTextStyles.h7Light.copyWith(
                        color: AppColors.mediumLightGray,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 58.h),
      ],
    );
  }
}
