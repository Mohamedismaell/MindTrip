import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

//Todo need to be replaced with real data
class PlaceDetailsVisitInfo extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsVisitInfo({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visit Info',
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.pureBlack,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            const Expanded(
              child: _VisitInfoTile(title: 'Best Time', value: 'Oct-Apr'),
            ),
            SizedBox(width: 25.w),
            const Expanded(
              child: _VisitInfoTile(title: 'Crowd Level', value: 'Medium'),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            const Expanded(
              child: _VisitInfoTile(
                title: 'Best For',
                value: 'Friends • Families',
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: _VisitInfoTile(
                title: 'Suggested Visit',
                value: place.category.displayName == 'Restaurants'
                    ? 'Evening'
                    : 'Morning',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _VisitInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _VisitInfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 76.h),
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h8SemiBold.copyWith(
              color: AppColors.pureBlack,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
