import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_shadows.dart';

class GradientElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final LinearGradient? gradient;
  // final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GradientElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.gradient,
    // this.borderRadius = 25,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.blueLightGradient,
        // borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [AppShadows.shadow1],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: padding,
        ),
        child: child,
      ),
    );
  }
}
