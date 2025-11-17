import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/splash/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';
import '../../../../../core/routes/navigation_helper.dart';
import '../../../../../core/widget/app_button.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          Image.asset(
            'assets/images/splash_screen/Pyramids.jpg',
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
                        text: 'Discover ',
                        style: AppTextStyles
                            .headLine4SemiBold
                            .copyWith(
                              color: AppColors.primaryBlue,
                            ),
                      ),
                      TextSpan(
                        text: 'Egypt',
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
                  'Start your greatest exploration where legends began.',
                  style: AppTextStyles.headLine8Light
                      .copyWith(color: AppColors.darkGray1),
                ),
                addVertical(58),
              ],
            ),
          ),
          OnboardingProgress(currentPage: 0),
          addVertical(58),
          Column(
            children: [
              AppButton(
                button: TextButton(
                  onPressed: () =>
                      NavigationHelper.goToOnBoarding2(
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
