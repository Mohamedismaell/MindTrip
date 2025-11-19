import 'package:flutter/material.dart';
import 'package:ttproj/core/routes/navigation_helper.dart';
import 'package:ttproj/features/splash/presentation/widget/main_title.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';
import '../../widget/main_image.dart';
import '../../widget/navigation_area.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! Image
          MainImage(
            imageAssets:
                'assets/images/splash_screen/Ai_Planner.png',
          ),
          //! Title
          MainTitle(
            firstTitle: 'AI ',
            secTitle: 'Planner',
            describtion:
                'Let AI create your dream trip across Egypt',
          ),
          //! Nav_Bars
          OnboardingProgress(currentPage: 1),
          addVertical(58),
          //! Nav_Button
          NavigationArea(
            navigateToNext: () =>
                NavigationHelper.goToOnBoarding3(context),
            navigateSkip: () =>
                NavigationHelper.goToInterests(context),
          ),
        ],
      ),
    );
  }
}
