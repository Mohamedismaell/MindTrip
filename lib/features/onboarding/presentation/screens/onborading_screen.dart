import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ttproj/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:ttproj/core/theme/extensions/theme_extension.dart';
import 'package:ttproj/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:ttproj/features/onboarding/presentation/widgets/onboarding_pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingPages(pageController: pageController),
                  SizedBox(height: 15.h),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotColor: context.colorTheme.surface,
                      activeDotColor: context.colorTheme.primary,
                    ),
                    // onDotClicked: (index) {},
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().updateIndex(
                          pageController.page!.toInt(),
                        );
                        // print('pageController.page ${pageController.page!.toInt()}');
                        // print('state.isLastPage ${state.isLastPage}');
                        state.isLastPage
                            ? context.read<AppGateCubit>().start()
                            : pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn,
                              );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Next'),
                          // SizedBox(width: 8.w),
                          // Icon(Icons.arrow_forward_outlined),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
