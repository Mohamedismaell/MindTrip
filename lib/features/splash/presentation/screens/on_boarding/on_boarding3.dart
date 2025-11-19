import 'package:flutter/material.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';
import '../../../../../core/routes/navigation_helper.dart';
import '../../widget/main_image.dart';
import '../../widget/main_title.dart';
import '../../widget/navigation_area.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          MainImage(
            imageAssets:
                'assets/images/splash_screen/Budget_Optimizer.png',
          ),
          //! Title
          MainTitle(
            firstTitle: 'Budget ',
            secTitle: 'Optimizer',
            describtion:
                'Smart AI matches your budget to your trip',
          ),
          //! Nav_Bars
          addVertical(58),
          OnboardingProgress(currentPage: 2),
          addVertical(58),
          //! Nav_Button
          NavigationArea(
            navigateToNext: () =>
                NavigationHelper.goToOnBoarding4(context),
            navigateSkip: () =>
                NavigationHelper.goToInterests(context),
          ),
        ],
      ),
    );
  }
}
