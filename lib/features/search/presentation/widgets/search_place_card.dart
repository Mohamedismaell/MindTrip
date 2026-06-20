import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

class SearchPlaceCard extends StatelessWidget {
  final PlaceEntity place;
  final VoidCallback onTap;

  const SearchPlaceCard({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

        elevation: 1,
        // color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),

        child: Padding(
          padding: EdgeInsets.all(8.r),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ImageSection(place: place),
              SizedBox(width: 14.w),
              Expanded(child: _CenterSection(place: place)),
              // SizedBox(width: 8.w),
              // _TrailingSection(place: place),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final PlaceEntity place;
  const _ImageSection({required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.w,
      height: 130.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: AppCachedImage(
              imagePath:
                  (place.imageUrls != null && place.imageUrls!.isNotEmpty)
                  ? place.imageUrls!.first
                  : '',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (place.isHiddenGem == true)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('✨', style: TextStyle(fontSize: 10.sp)),
                    SizedBox(width: 4.w),
                    Text(
                      'Hidden Gem',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (place.imageUrls != null && place.imageUrls!.length > 1)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${place.imageUrls!.length}',
                      style: AppTextStyles.h10Regular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CenterSection extends StatelessWidget {
  final PlaceEntity place;
  const _CenterSection({required this.place});

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
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              children: [
                _StatusBadge(isOpened: place.isOpened),
                if (place.openingHours != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    place.openingHours.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorTheme.outline,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ],
            ), // PlaceEntity doesn't have isOpened
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 16.sp),
            SizedBox(width: 2.w),
            Text(
              (place.rating ?? 0.0).toStringAsFixed(1),
              style: AppTextStyles.h10Bold.copyWith(),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '(${place.reviewCount ?? 0} reviews)',
                style: AppTextStyles.h10Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(
              place.category.iconData,
              size: 14.sp,
              color: context.colorTheme.primary,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                place.category.displayName,
                style: AppTextStyles.h10SemiBold.copyWith(
                  color: context.colorTheme.primary,
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
              color: context.colorTheme.outline,
              size: 14.sp,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                place.location.cityEn.isNotEmpty
                    ? place.location.cityEn
                    : place.location.city,
                style: AppTextStyles.h9SemiBold.copyWith(
                  color: context.colorTheme.outline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (place.price != null && place.price! > 0) ...[
              Column(
                children: [
                  Text(
                    'EGP ${place.price!.toInt()}',
                    style: AppTextStyles.h9SemiBold.copyWith(
                      color: context.colorTheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Per Person',
                    style: AppTextStyles.h10Regular.copyWith(
                      color: context.colorTheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),

        // SizedBox(height: 10.h),
        // Wrap(
        //   spacing: 6.w,
        //   runSpacing: 4.h,
        //   children: [_InterestChip(label: place.category.displayName)],
        // ),
      ],
    );
  }
}

// class _TrailingSection extends StatelessWidget {
//   final PlaceEntity place;
//   const _TrailingSection({required this.place});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [

//         // SizedBox(height: 12.h),
//         // Container(
//         //   padding: EdgeInsets.all(6.r),
//         //   decoration: BoxDecoration(
//         //     color: context.colorTheme.surfaceContainer,
//         //     shape: BoxShape.circle,
//         //   ),
//         //   child: Icon(
//         //     Icons.chevron_right_rounded,
//         //     size: 20.sp,
//         //     color: context.colorTheme.onSurfaceVariant,
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// class _InterestChip extends StatelessWidget {
//   final String label;
//   const _InterestChip({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//       decoration: BoxDecoration(
//         color: context.colorTheme.primary.withValues(alpha: 0.08),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _getInterestIcon(label),
//           SizedBox(width: 4.w),
//           Text(
//             label,
//             style: context.textTheme.labelSmall?.copyWith(
//               color: context.colorTheme.onSurface,
//               fontSize: 10.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Widget _getInterestIcon(String label) {
//   IconData icon;
//   if (label.contains('History')) {
//     icon = Icons.museum_rounded;
//   } else if (label.contains('Outdoor')) {
//     icon = Icons.wb_sunny_rounded;
//   } else if (label.contains('Nature')) {
//     icon = Icons.eco_rounded;
//   } else if (label.contains('Education')) {
//     icon = Icons.school_rounded;
//   } else {
//     icon = Icons.check_circle_outline_rounded;
//   }

//   return Icon(icon, size: 10.sp, color: Colors.green[700]);
// }
// }

class _StatusBadge extends StatelessWidget {
  final String? isOpened;
  const _StatusBadge({required this.isOpened});
  @override
  Widget build(BuildContext context) {
    final openStatus = isOpened == 'false' ? 'Closed' : 'Open';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: openStatus == 'Open'
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 3.r,
            backgroundColor: openStatus == 'Open' ? Colors.green : Colors.red,
          ),
          SizedBox(width: 6.w),
          Text(
            openStatus,
            style: AppTextStyles.h10Regular.copyWith(
              color: openStatus == 'Open' ? Colors.green : Colors.red,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
