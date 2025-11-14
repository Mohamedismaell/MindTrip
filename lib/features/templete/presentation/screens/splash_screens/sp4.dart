import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/templete/presentation/widget/app_button.dart';
import 'package:ttproj/features/templete/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';

class Sp4 extends StatelessWidget {
  const Sp4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          Image.asset(
            'assets/images/splash_screen/Hidden_Gems.png',
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
                        text: 'Hidden ',
                        style: AppTextStyles
                            .headLine4SemiBold
                            .copyWith(
                              color: AppColors.primaryBlue,
                            ),
                      ),
                      TextSpan(
                        text: 'Gems',
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
                  'Discover secret cafes, cozy restaurants, and fun spots across Egypt.',
                  style: AppTextStyles.headLine8Light
                      .copyWith(color: AppColors.darkGray1),
                ),
                addVertical(58),
              ],
            ),
          ),
          OnboardingProgress(currentPage: 3),
          addVertical(58),
          AppButton(
            button: TextButton(
              onPressed: () => context.go('/interests'),
              child: Text('Get Started'),
            ),
          ),
          addVertical(20),
        ],
      ),
    );
  }
}
