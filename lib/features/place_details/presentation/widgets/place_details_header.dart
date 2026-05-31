import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsHeader extends StatelessWidget {
  final PlaceModel place;
  
  const PlaceDetailsHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                place.name,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorTheme.onSurface,
                ),
              ),
            ),
            if (place.price != null) ...[
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${place.price?.toStringAsFixed(0)}',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    'per night',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGray2,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primaryBlue, size: 16.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                place.location.address,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (place.rating != null)
          Row(
            children: [
              RatingStars(
                rating: place.rating,
                size: 20.sp,
                showText: true,
                style: AppTextStyles.h8SemiBold,
              ),
              if (place.reviewCount != null) ...[
                SizedBox(width: 8.w),
                Text(
                  '(${place.reviewCount} reviews)',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGray2,
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }
}
