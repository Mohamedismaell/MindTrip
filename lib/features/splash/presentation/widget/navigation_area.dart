import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../utility.dart';

class NavigationArea extends StatelessWidget {
  const NavigationArea({
    super.key,
    required this.navigateToNext,
    this.navigateSkip,
    this.nextButtonText = 'Next',
    this.skipButtonText = 'Skip',
  });
  final void Function() navigateToNext;
  final void Function()? navigateSkip;
  final String nextButtonText;
  final String skipButtonText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          button: TextButton(
            onPressed: () => navigateToNext(),
            child: Text(nextButtonText),
          ),
        ),
        addVertical(20),
        if (navigateSkip != null) ...[
          addVertical(20),
          TextButton(
            onPressed: navigateSkip,
            child: Text(
              skipButtonText,
              style: AppTextStyles.headLine7Regular
                  .copyWith(color: AppColors.darkGray2),
            ),
          ),
        ],
      ],
    );
  }
}
