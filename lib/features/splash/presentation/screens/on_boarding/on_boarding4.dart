import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';

import '../../../../../core/routes/navigation_helper.dart';
import '../../../../../core/widget/app_button.dart';
import '../../widget/main_image.dart';
import '../../widget/main_title.dart';
import '../../widget/navigation_area.dart';

class Sp4 extends StatelessWidget {
  const Sp4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          MainImage(
            imageAssets:
                'assets/images/splash_screen/Hidden_Gems.png',
          ),
          //! Title
          MainTitle(
            firstTitle: 'Hidden ',
            secTitle: 'Gems',
            describtion:
                'Discover secret cafes, cozy restaurants, and fun spots across Egypt.',
          ),
          //! Nav_Bars
          OnboardingProgress(currentPage: 3),
          addVertical(58),
          //! Nav_Button
          NavigationArea(
            navigateToNext: () =>
                NavigationHelper.goToInterests(context),
            nextButtonText: 'Get Started',
          ),
        ],
      ),
    );
  }
}
