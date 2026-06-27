import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';
import 'package:intl/intl.dart';

class TripAccommodationCard extends StatelessWidget {
  const TripAccommodationCard({
    super.key,
    required this.accommodation,
    required this.tripStart,
    required this.tripEnd,
    required this.tripId,
  });

  final PlanPlaceEntity accommodation;
  final DateTime tripStart;
  final DateTime tripEnd;
  final String tripId;

  int get _nights => tripEnd.difference(tripStart).inDays;

  @override
  Widget build(BuildContext context) {
    final String dateRange =
        '${DateFormat('dd MMM').format(tripStart)} - ${DateFormat('dd MMM').format(tripEnd)}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorTheme.outline, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Hero(
            tag: 'trip-image-$tripId',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: SizedBox(
                width: double.infinity,
                height: 202.h,
                child: AppCachedImage(
                  imagePath: accommodation.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accommodation:',
                  style: AppTextStyles.h6Bold,
                ),
                SizedBox(height: 14.h),
                Text(
                  accommodation.name,
                  style: AppTextStyles.h8Bold.copyWith(
                    color: context.colorTheme.onSurface.withValues(alpha: 0.8),
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                // Meta Row
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  children: [
                    _IconText(
                      icon: Icons.location_on_outlined,
                      text: accommodation.cityEn,
                    ),
                    _IconText(
                      icon: Icons.access_time,
                      text: '$dateRange • $_nights Nights',
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                // Price
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${accommodation.cost.toInt()} EGP',
                    style: AppTextStyles.h9Bold.copyWith(
                      color: AppColors.customgreeen2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20.sp, color: context.colorTheme.outline),
        SizedBox(width: 4.w),
        Text(
          text,
          style: AppTextStyles.h10Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
