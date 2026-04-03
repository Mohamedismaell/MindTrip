import 'package:flutter/material.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class CustomHeadLine extends StatelessWidget {
  const CustomHeadLine({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    this.firstStyle,
    this.secondStyle,
    this.thirdTitle,
  });
  final String firstTitle;
  final String secondTitle;
  final String? thirdTitle;
  final TextStyle? firstStyle;
  final TextStyle? secondStyle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstTitle,
            style:
                firstStyle?.copyWith(color: context.colorTheme.primary) ??
                context.textTheme.headlineLarge!.copyWith(
                  color: context.colorTheme.primary,
                ),
          ),
          TextSpan(
            text: secondTitle,
            style:
                secondStyle?.copyWith(color: context.colorTheme.onSurface) ??
                context.textTheme.headlineLarge,
          ),
          TextSpan(
            text: thirdTitle,
            style:
                firstStyle?.copyWith(color: context.colorTheme.primary) ??
                context.textTheme.headlineLarge!.copyWith(
                  color: context.colorTheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
