import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/models/onboarding_model.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            context.read<OnboardingCubit>().updateIndex(
              pageController.page!.toInt(),
            );
          },
          controller: pageController,
          itemCount: OnboardingModel.onboardingList.length,
          itemBuilder: (context, index) {
            final item = OnboardingModel.onboardingList[index];
            return SizedBox.expand(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      item.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: item.firstTitle,
                                  style: context.textTheme.headlineLarge!
                                      .copyWith(
                                        color: context.colorTheme.primary,
                                      ),
                                ),
                                TextSpan(
                                  text: item.secondTitle,
                                  style: context.textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            item.quote,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
