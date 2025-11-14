import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/templete/presentation/widget/app_button.dart';
import 'package:ttproj/features/templete/presentation/widget/onboarding_progress_bar.dart';
import 'package:ttproj/utility.dart';

class Sp2 extends StatelessWidget {
  const Sp2({super.key});

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
                  onPressed: () => context.go('/sp3'),
                  child: Text('Next'),
                ),
              ),
              addVertical(20),
              TextButton(
                onPressed: () => context.go('/interests'),
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
