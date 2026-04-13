import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.data});

  final ProfileReviewData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: AppTextStyles.h8Bold.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      data.location,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  data.rating,
                  (_) => Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Icon(
                      Icons.star_rounded,
                      size: 20.sp,
                      color: const Color(0xFFF8BD00),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            data.body,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
