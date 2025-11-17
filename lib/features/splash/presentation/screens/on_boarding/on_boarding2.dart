import 'package:flutter/material.dart';
import 'package:ttproj/core/routes/navigation_helper.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';

import '../../../../../core/widget/app_button.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          Image.asset(
            'assets/images/splash_screen/Ai_Planner.png',
            width: double.infinity,
            height: 544,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 340,
            child: Column(
              children: [
                //! mian text
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'AI ',
                        style: AppTextStyles
                            .headLine4SemiBold
                            .copyWith(
                              color: AppColors.primaryBlue,
                            ),
                      ),
                      TextSpan(
                        text: 'Planner',
                        style: AppTextStyles
                            .headLine4SemiBold
                            .copyWith(
                              color: AppColors.darkGray1,
                            ),
                      ),
                    ],
                  ),
                ),
                addVertical(38),
                Text(
                  textAlign: TextAlign.center,
                  'Let AI create your dream trip across Egypt',
                  style: AppTextStyles.headLine8Light
                      .copyWith(color: AppColors.darkGray1),
                ),
                addVertical(58),
              ],
            ),
          ),
          OnboardingProgress(currentPage: 1),
          addVertical(58),
          Column(
            children: [
              AppButton(
                button: TextButton(
                  onPressed: () =>
                      NavigationHelper.goToOnBoarding3(
                        context,
                      ),
                  child: Text('Next'),
                ),
              ),
              addVertical(20),
              TextButton(
                onPressed: () =>
                    NavigationHelper.goToInterests(context),
                child: Text(
                  'Skip',
                  style: AppTextStyles.headLine7Regular
                      .copyWith(color: AppColors.darkGray2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
