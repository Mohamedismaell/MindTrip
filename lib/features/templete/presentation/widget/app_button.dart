// lib/core/widgets/app_button.dart
import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_shadows.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LinearGradient? gradient;
  final Color? solidColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.solidColor,
    this.padding,
    this.color,
  });

  const AppButton.solid({
    super.key,
    required this.text,
    required this.onPressed,
    this.solidColor,
    this.padding,
    this.color,
  }) : gradient = null;

  @override
  Widget build(BuildContext context) {
    final isGradient =
        gradient != null || solidColor == null;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isGradient
            ? Colors.transparent
            : (solidColor ?? Colors.grey),
        shadowColor: isGradient ? Colors.transparent : null,
        elevation: isGradient ? 0 : 2,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: 62.5,
              vertical: 12,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.headLine7Bold.copyWith(
          color: isGradient ? AppColors.pureWhite : color,
        ),
      ),
    );

    if (!isGradient) return button;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueLightGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [AppShadows.shadow1],
      ),
      child: button,
    );
  }
}
