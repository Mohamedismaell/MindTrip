import 'package:flutter/material.dart';
import 'package:ttproj/features/splash/presentation/widget/main_image.dart';
import 'package:ttproj/features/splash/presentation/widget/main_title.dart';
import 'package:ttproj/features/splash/presentation/widget/navigation_area.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';
import '../../../../../core/routes/navigation_helper.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          MainImage(
            imageAssets:
                'assets/images/splash_screen/Pyramids.jpg',
          ),
          //! Title
          MainTitle(
            firstTitle: 'Discover ',
            secTitle: 'Egypt',
            describtion:
                'Start your greatest exploration where legends began.',
          ),
          //! Nav_Bars
          addVertical(58),
          OnboardingProgress(currentPage: 0),
          addVertical(58),
          //! Nav_Button
          NavigationArea(
            navigateToNext: () =>
                NavigationHelper.goToOnBoarding2(context),
            navigateSkip: () =>
                NavigationHelper.goToInterests(context),
          ),
        ],
      ),
    );
  }
}
