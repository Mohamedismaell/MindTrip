import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsLocationSection extends StatelessWidget {
  final PlaceModel place;
  const PlaceDetailsLocationSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            height: 150.h,
            width: double.infinity,
            color: AppColors.primaryLightGray,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 40.sp, color: AppColors.darkGray2),
                  SizedBox(height: 8.h),
                  Text('Map Placeholder', style: context.textTheme.bodyMedium),
                  Text(
                    '${place.location.latitude}, ${place.location.longitude}',
                    style: context.textTheme.bodySmall?.copyWith(color: AppColors.darkGray2),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, size: 20.sp, color: AppColors.darkGray2),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                place.location.address,
                style: context.textTheme.bodyMedium?.copyWith(color: context.colorTheme.outline),
              ),
            ),
          ],
        )
      ],
    );
  }
}
