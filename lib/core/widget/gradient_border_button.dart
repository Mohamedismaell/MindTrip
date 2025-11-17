import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';

class AppGradientBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double? width;
  final double? height;

  const AppGradientBorderButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 62.5,
              vertical: 12,
            ),
            foregroundColor: Colors
                .black, // text color inside white button
            textStyle: AppTextStyles.headLine7Regular,
          ),
          child: Text(
            text,
            style: AppTextStyles.headLine7Bold.copyWith(
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}
