import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/features/templete/presentation/widget/app_button.dart';
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
                Container(
                  alignment: AlignmentDirectional.center,
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
                                    color: AppColors
                                        .primaryBlue,
                                  ),
                            ),
                            TextSpan(
                              text: 'Planner',
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
                        'Let AI create your dream trip across Egypt',
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
                onPressed: () => context.go('/sp3'),
                text: 'Next',
              ),
              addVertical(20),
              TextButton(
                onPressed: () => context.go(
                  '/interests',
                ), //  Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => InterestsScreen(),
                //   ),
                // ),
                child: Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
