import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';

class AiPlannerIntroScreen extends StatelessWidget {
  const AiPlannerIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 43.0.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Plan your perfect trip',
                style: context.textTheme.headlineMedium,
              ),
              SizedBox(height: 12.h),
              Text(
                'Answer a few quick questions or let AI plan it for you.',
                textAlign: TextAlign.center,
                style: AppTextStyles.h7Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
              SizedBox(height: 32.h),
              SvgPicture.asset(
                AiPlannerAssets.introIllustration,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 32.h),

              // Start Planning — new trip (no tripId)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.5.w),
                child: CustomGradientButton(
                  text: 'Start Planning',
                  onTap: () => context.push(AppRoutes.aiPlannerFlow),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
