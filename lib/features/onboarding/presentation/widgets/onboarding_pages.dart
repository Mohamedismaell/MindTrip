import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/wavy_clipper.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
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
            context.read<OnboardingCubit>().updateIndex(value);
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
                    child: ClipPath(
                      clipper: WavyClipper(),
                      child: Image.asset(
                        item.imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomHeadLine(
                            firstTitle: item.firstTitle,
                            secondTitle: item.secondTitle,
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
