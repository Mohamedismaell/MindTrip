import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';

class ExploreTrendingList extends StatefulWidget {
  const ExploreTrendingList({super.key});

  @override
  State<ExploreTrendingList> createState() => _ExploreTrendingListState();
}

class _ExploreTrendingListState extends State<ExploreTrendingList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ExploreCubit>().loadMoreTrendingPlaces();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 200;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      buildWhen: (previous, current) =>
          previous.trendingPlacesStatus != current.trendingPlacesStatus ||
          previous.trendingPlaces != current.trendingPlaces,
      builder: (context, state) {
        final trendingPlacesStatus = state.trendingPlacesStatus;
        if (trendingPlacesStatus.isFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AppErrorWidget(
                message: state.trendingPlacesError.isNotEmpty 
                    ? state.trendingPlacesError 
                    : 'Failed to load trending places',
                imageSize: 80,
                onPressed: () =>
                    context.read<ExploreCubit>().loadTrendingPlacesFirstPage(),
              ),
            ),
          );
        }

        final isLoading =
            trendingPlacesStatus.isLoading || trendingPlacesStatus.isInitial;
        final trendingPlaces = isLoading
            ? DummyData.popularPlaces
            : state.trendingPlaces.items;

        if (!isLoading && trendingPlaces.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AppErrorWidget.noInfo(
                message: 'No trending places found at the moment.',
                imageSize: 80,
                onRetry: () =>
                    context.read<ExploreCubit>().loadTrendingPlacesFirstPage(),
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 110.h,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount:
                    trendingPlaces.length +
                    (state.trendingPlaces.isMoreLoading ? 2 : 0),
                separatorBuilder: (_, _) => SizedBox(width: 17.w),
                itemBuilder: (context, index) {
                  if (index >= trendingPlaces.length) {
                    return const Skeletonizer(
                      enabled: true,
                      child: _TrendingCard(item: DummyData.place),
                    );
                  }
                  final item = trendingPlaces[index];
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
        border: Border.all(color: context.colorTheme.outline, width: 0.8),
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
