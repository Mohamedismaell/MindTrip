import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsOverview extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailsOverview({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final description = place.description?.trim();
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    final preview = description.length > 155
        ? '${description.substring(0, 155).trimRight()}...'
        : description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.pureBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGray1,
              fontSize: 15.sp,
              height: 1.5,
            ),
            children: [
              TextSpan(text: preview),
              if (description.length > preview.length)
                TextSpan(
                  text: ' See More',
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
