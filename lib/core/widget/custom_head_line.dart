import 'package:flutter/material.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class CustomHeadLine extends StatelessWidget {
  const CustomHeadLine({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
  });
  final String firstTitle;
  final String secondTitle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstTitle,
            style: context.textTheme.headlineLarge!.copyWith(
              color: context.colorTheme.primary,
            ),
          ),
          TextSpan(text: secondTitle, style: context.textTheme.headlineLarge),
        ],
      ),
    );
  }
}
