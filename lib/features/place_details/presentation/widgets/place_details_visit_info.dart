import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

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
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.pureBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            const Expanded(
              child: _VisitInfoTile(title: 'Best Time', value: 'Oct-Apr'),
            ),
            SizedBox(width: 20.w),
            const Expanded(
              child: _VisitInfoTile(title: 'Crowd Level', value: 'Medium'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
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
      constraints: BoxConstraints(minHeight: 54.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F8),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.pureBlack,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGray1,
              fontSize: 14.sp,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
