import 'package:flutter/material.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class OutlinedActionButton extends StatelessWidget {
  const OutlinedActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fontSize,
    this.height,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? fontSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      text: label,
      color: context.colorTheme.primary,
      textStyle: AppTextStyles.h9Bold.copyWith(
        color: context.colorTheme.primary,
      ),
      actionIcon: icon,
    );
  }
}
