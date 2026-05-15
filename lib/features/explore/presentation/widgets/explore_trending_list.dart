import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class ExploreTrendingList extends StatelessWidget {
  const ExploreTrendingList({super.key, required this.items});

  final List<PlaceModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, _) => SizedBox(width: 17.w),
          itemBuilder: (context, index) {
            final item = items[index];
            return _TrendingCard(item: item);
          },
        ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.item});

  final PlaceModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,

      decoration: BoxDecoration(
        color: AppColors.primaryLightGray.withValues(alpha: 0.4),
        // boxShadow: [AppShadows.tourPackagesCard],
        border: Border.all(
          color: context.colorTheme.onSurfaceVariant,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            //! Handle no image later
            child: AppCachedImage(
              width: double.infinity,
              height: 70.h,
              imageUrl: item.imageUrls?.first ?? '',
            ),
          ),
          SizedBox(height: 7.h),
          // Title
          Text(
            item.name,
            style: context.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
