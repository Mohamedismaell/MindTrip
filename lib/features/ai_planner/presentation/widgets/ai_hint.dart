import 'package:flutter/material.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class AiHint extends StatelessWidget {
  const AiHint({super.key, required this.message, this.centerText = false});

  final String message;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centerText
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
        ),
        // SizedBox(height: 14.h),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child:
        //
        // ),
      ],
    );
  }
}
