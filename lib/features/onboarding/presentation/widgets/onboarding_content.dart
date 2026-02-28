import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';

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
                InkWell(
                  onTap: () {
                    // context.read<OnboardingCubit>().updateIndex(
                    //   pageController.page!.toInt(),
                    // );
                    // print('pageController.page ${pageController.page!.toInt()}');
                    // print('state.isLastPage ${state.isLastPage}');
                    // state.isLastPage
                    //     ? context.read<AppGateCubit>().start()
                    //     : pageController.nextPage(
                    //         duration: const Duration(milliseconds: 400),
                    //         curve: Curves.easeIn,
                    //       );
                    isLastpage
                        ? context.push(AppRoutes.interests)
                        : pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInSine,
                          );
                  },
                  child: CustomGradientButton(
                    text: isLastpage ? 'Get Started' : 'Next',
                  ),
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: !isLastpage,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    onPressed: () {
                      context.push(AppRoutes.interests);
                    },
                    child: Text(
                      'Skip',
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
