// lib/core/widgets/app_button.dart
import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_shadows.dart';

class AppButton extends StatelessWidget {
  final TextButton button;
  // final Color textColor;
  final LinearGradient? gradientColor;
  final double? width;
  const AppButton({
    super.key,
    required this.button,
    this.gradientColor,
    this.width,
    // required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 62.5,
      //   vertical: 12,
      // ),
      width: width,
      decoration: BoxDecoration(
        gradient:
            gradientColor ?? AppColors.blueLightGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [AppShadows.shadow1],
      ),
      child: button,
    );
  }
}
