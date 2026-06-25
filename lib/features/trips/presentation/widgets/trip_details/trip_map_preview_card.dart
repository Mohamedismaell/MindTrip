import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

class TripMapPreviewCard extends StatelessWidget {
  const TripMapPreviewCard({
    super.key,
    required this.onViewMap,
    // required this.generatedPlan,
  });

  // final GeneratedPlanEntity generatedPlan;
  final VoidCallback? onViewMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorTheme.outline),
      ),
      child: Column(
        children: [
          Text('Your Trip Map', style: AppTextStyles.h7Bold),
          SizedBox(height: 18.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 181.h,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(
                    imagePath: 'assets/images/map/map_preview.webp',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: CustomOutlinedButton(
              key: const Key('trip-map-button'),
              text: 'View full map',
              actionIcon: Icons.map_outlined,
              onPressed: onViewMap,
              color: context.colorTheme.primary,

              textStyle: AppTextStyles.h8Bold.copyWith(
                color: context.colorTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
