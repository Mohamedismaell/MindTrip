import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../utility.dart';

class InterestsTitle extends StatelessWidget {
  const InterestsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What are your interests?',
          style: AppTextStyles.headLine5Medium.copyWith(
            color: AppColors.darkGray1,
          ),
        ),
        addVertical(8),
        Text(
          'You can select multiple choices',
          style: AppTextStyles.headLine8Regular.copyWith(
            color: AppColors.mediumLightGray,
          ),
        ),
        addVertical(34),
      ],
    );
  }
}
