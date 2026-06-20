import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPlaceCard extends StatelessWidget {
  final PlaceEntity place;
  final VoidCallback onTap;

  const SearchPlaceCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: place.imageUrls?.firstOrNull ?? '',
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: context.colorTheme.surfaceContainer,
                ),
                errorWidget: (context, url, error) => Container(
                  color: context.colorTheme.surfaceContainer,
                  child: Icon(Icons.image_not_supported_outlined, size: 20.sp),
                ),
              ),
            ),
            12.horizontalSpace,
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16.sp,
                        color: Colors.amber,
                      ),
                      4.horizontalSpace,
                      Text(
                        '${place.rating}',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colorTheme.onSurface,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        '•',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        place.category.displayName,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        '•',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        place.location.cityEn.isNotEmpty
                            ? place.location.cityEn
                            : place.location.city,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Outbound Icon
            Icon(
              Icons.call_made_rounded,
              size: 20.sp,
              color: context.colorTheme.outline.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
