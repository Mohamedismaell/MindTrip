import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:intl/intl.dart';

class ScheduleTripTile extends StatelessWidget {
  const ScheduleTripTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final start = trip.tripStart;
    final end = trip.tripEnd;
    final dateRangeStr = start != null && end != null
        ? '${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d, yyyy').format(end)}'
        : 'Dates not set';

    final isLocal = !trip.coverAsset.startsWith('http');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          // Cover Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 56.w,
              height: 56.w,
              child: isLocal
                  ? Image.asset(
                      trip.coverAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _FallbackCover(),
                    )
                  : Image.network(
                      trip.coverAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _FallbackCover(),
                    ),
            ),
          ),
          SizedBox(width: 14.w),

          // Trip Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        trip.title,
                        style: AppTextStyles.h9Bold.copyWith(
                          color: context.colorTheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (trip.status == TripStatus.draft)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'Draft',
                          style: AppTextStyles.h10Medium.copyWith(
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 12.sp,
                      color: context.colorTheme.primary,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        trip.destination,
                        style: AppTextStyles.h10Regular.copyWith(
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  dateRangeStr,
                  style: AppTextStyles.h10Medium.copyWith(
                    color: context.colorTheme.outline,
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

class _FallbackCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.primary.withValues(alpha: 0.15),
      child: Center(
        child: Icon(
          Icons.travel_explore_rounded,
          size: 24.sp,
          color: context.colorTheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
