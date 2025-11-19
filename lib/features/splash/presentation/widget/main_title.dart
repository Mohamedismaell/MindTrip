import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../utility.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
    required this.firstTitle,
    required this.secTitle,
    required this.describtion,
  });

  final String firstTitle;
  final String secTitle;
  final String describtion;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        children: [
          //! mian text
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: firstTitle,
                  style: AppTextStyles.headLine4SemiBold
                      .copyWith(
                        color: AppColors.primaryBlue,
                      ),
                ),
                TextSpan(
                  text: secTitle,
                  style: AppTextStyles.headLine4SemiBold
                      .copyWith(color: AppColors.darkGray1),
                ),
              ],
            ),
          ),
          addVertical(38),
          Text(
            textAlign: TextAlign.center,
            describtion,
            style: AppTextStyles.headLine8Light.copyWith(
              color: AppColors.darkGray1,
            ),
          ),
        ],
      ),
    );
  }
}
