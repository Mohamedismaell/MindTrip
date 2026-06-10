import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';

class ExploreTrendingList extends StatelessWidget {
  const ExploreTrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      buildWhen: (previous, current) =>
          previous.trendingPlacesStatus != current.trendingPlacesStatus ||
          previous.trendingPlaces != current.trendingPlaces,
      builder: (context, state) {
        if (state.trendingPlacesStatus == ExploreDataStatus.failure) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              message: state.trendingPlacesError,
              imageSize: 60,
              onPressed: () => context.read<ExploreCubit>().loadTrendingPlaces(),
            ),
          );
        }

        final isLoading = state.trendingPlacesStatus == ExploreDataStatus.loading ||
            state.trendingPlacesStatus == ExploreDataStatus.initial;
        final items = isLoading ? DummyData.popularPlaces : state.trendingPlaces;

        if (!isLoading && items.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
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
          ),
        );
      },
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.item});

  final PlaceEntity item;

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
              imagePath: item.imageUrls?.first ?? '',
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
