import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/templete/presentation/widget/app_button.dart';
import 'package:ttproj/utility.dart';

class Sp3 extends StatelessWidget {
  const Sp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! image
          Image.asset(
            'assets/images/splash_screen/Budget_Optimizer.png',
            width: double.infinity,
            height: 544,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 340,
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    children: [
                      //! mian text
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Budget ',
                              style: AppTextStyles
                                  .headLine4SemiBold
                                  .copyWith(
                                    color: AppColors
                                        .primaryBlue,
                                  ),
                            ),
                            TextSpan(
                              text: 'Optimizer',
                              style: AppTextStyles
                                  .headLine4SemiBold
                                  .copyWith(
                                    color:
                                        AppColors.darkGray1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      addVertical(38),
                      Text(
                        textAlign: TextAlign.center,
                        'Smart AI matches your budget to your trip',
                        style: AppTextStyles.headLine8Light
                            .copyWith(
                              color: AppColors.darkGray1,
                            ),
                      ),
                      addVertical(58),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Container(
                width: 25.88,
                // width: 45.29,
                height: 7,
                decoration: ShapeDecoration(
                  color: AppColors.primaryLightBlue1,
                  // color: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Container(
                width: 25.88,
                // width: 45.29,
                height: 7,
                decoration: ShapeDecoration(
                  color: AppColors.primaryLightBlue1,
                  // color: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Container(
                width: 25.88,
                // width: 45.29,
                height: 7,
                decoration: ShapeDecoration(
                  color: AppColors.primaryLightBlue1,
                  // color: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Container(
                width: 25.88,
                // width: 45.29,
                height: 7,
                decoration: ShapeDecoration(
                  color: AppColors.primaryLightBlue1,
                  // color: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
          addVertical(58),
          Column(
            children: [
              AppButton.solid(
                text: 'Next',
                onPressed: () => context.go('/sp4'),
              ),
              addVertical(20),
              TextButton(
                onPressed: () => context.go('/interests'),
                child: Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
