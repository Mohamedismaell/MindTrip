import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsHeader extends StatelessWidget {
  final PlaceEntity place;

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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.pureBlack,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
            ),
            if (place.price != null) ...[
              SizedBox(width: 12.w),
              Text(
                '\$${place.price!.toStringAsFixed(0)}',
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.customgreeen,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.primaryBlue,
              size: 18.r,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                place.location.address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGray2,
                  fontSize: 15.sp,
                ),
              ),
            ),
            if (place.rating != null) ...[
              SizedBox(width: 12.w),
              Icon(
                Icons.star_rounded,
                color: AppColors.customYellow,
                size: 20.r,
              ),
              SizedBox(width: 4.w),
              Text(
                _ratingLabel,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGray2,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  String get _ratingLabel {
    final rating = place.rating?.toStringAsFixed(1) ?? '';
    if (place.reviewCount == null) return rating;
    return '$rating (${_compactCount(place.reviewCount!)})';
  }

  String _compactCount(int count) {
    if (count >= 1000) {
      final value = count / 1000;
      return '${value.toStringAsFixed(value >= 10 ? 0 : 1)}k';
    }
    return count.toString();
  }
}
