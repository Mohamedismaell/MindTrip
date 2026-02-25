import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttproj/core/theme/extensions/theme_extension.dart';
import 'package:ttproj/features/onboarding/presentation/models/user_details.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({
    super.key,
    required this.pageController,
    // required this.carouselController,
  });
  final PageController pageController;
  // final CarouselSliderController carouselController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: OnboardingModel.onboardingList.length,
        itemBuilder: (context, index) {
          final item = OnboardingModel.onboardingList[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                item.title,
                style: context.textTheme.headlineLarge!.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 220.w,
                child: Text(
                  textAlign: TextAlign.center,
                  'All news in one place, be the first to know last news',
                  style: context.textTheme.bodyLarge,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
