import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_buttons.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_header.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
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
              //! Edit latter
              Center(
                child: CustomGradientButton(
                  child: Text('Save', style: context.textTheme.labelLarge),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
