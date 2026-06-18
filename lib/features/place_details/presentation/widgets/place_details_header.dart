import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsHeader extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final rating = place.rating?.toStringAsFixed(1) ?? '';
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
                style: AppTextStyles.h6Bold.copyWith(
                  color: AppColors.pureBlack,
                ),
              ),
            ),
            if (place.price != null) ...[
              SizedBox(width: 12.w),
              Text(
                '\$${place.price!.toStringAsFixed(0)} AVG',
                style: AppTextStyles.h8Bold.copyWith(
                  color: AppColors.customgreeen,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Skeleton.shade(
              // enabled: place.rating == null,
              child: SvgPicture.asset(
                HomeAssets.locationIcon,
                colorFilter: ColorFilter.mode(
                  context.colorTheme.primary,
                  BlendMode.srcIn,
                ),
                width: 18.w,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '${place.location.address}, Egypt',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),
            // Rating
            if (place.rating != null) ...[
              SizedBox(width: 12.w),
              Icon(
                Icons.star_rounded,
                color: AppColors.customYellow,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                rating,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${place.reviewCount.toString()})',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
