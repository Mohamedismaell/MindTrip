import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';

class AuthHeadline extends StatelessWidget {
  const AuthHeadline({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    this.thirdTitle,
  });

  final String firstTitle;
  final String secondTitle;
  final String? thirdTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          //Todo : Export Back arrow icon
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        // SizedBox(width: 10.w),
        Expanded(
          child: CustomHeadLine(
            firstTitle: firstTitle,
            secondTitle: secondTitle,
            firstStyle: AppTextStyles.h5Bold,
            secondStyle: AppTextStyles.h5Bold,
            thirdTitle: thirdTitle,
          ),
        ),
      ],
    );
  }
}
