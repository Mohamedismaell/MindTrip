import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_buttons.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_header.dart';

class InterestSelectoin extends StatelessWidget {
  const InterestSelectoin({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 46.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterestsHeader(),
              Expanded(child: InterestesButton()),
              SizedBox(height: 34.h),
              Center(
                child: CustomGradientButton(
                  text: AppStrings.save,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
