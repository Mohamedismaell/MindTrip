import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/favorite_place_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeHiddenGemsSection extends StatefulWidget {
  const HomeHiddenGemsSection({super.key});

  @override
  State<HomeHiddenGemsSection> createState() => _HomeHiddenGemsSectionState();
}

class _HomeHiddenGemsSectionState extends State<HomeHiddenGemsSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().loadMoreHiddenGems();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 300;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.hiddenGemsStatus != current.hiddenGemsStatus ||
          previous.hiddenGems.items != current.hiddenGems.items ||
          previous.hiddenGems.isMoreLoading != current.hiddenGems.isMoreLoading,
      builder: (context, state) {
        final isLoading =
            state.hiddenGemsStatus.isLoading ||
            state.hiddenGemsStatus.isInitial;
        final places = isLoading
            ? DummyData.exploreCardPlaces
            : state.hiddenGems.items;

        if (state.hiddenGemsStatus.isFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AppErrorWidget(
                imageSize: 100,
                message: state.hiddenGemsError.isNotEmpty
                    ? state.hiddenGemsError
                    : 'Failed to load hidden gems',
                onPressed: () {
                  context.read<HomeCubit>().loadFirstPageHiddenGems();
                },
              ),
            ),
          );
        }

        if (!isLoading && places.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: AppErrorWidget.noInfo(
                imageSize: 100,
                message: 'No hidden gems found at the moment.',
                onRetry: () {
                  context.read<HomeCubit>().loadFirstPageHiddenGems();
                },
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
          child: SizedBox(
            height: 240.h,
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 20.w),
                clipBehavior: Clip.none,
                itemCount:
                    places.length + (state.hiddenGems.isMoreLoading ? 2 : 0),
                separatorBuilder: (_, context) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  if (index >= places.length) {
                    return const Skeletonizer(
                      enabled: true,
                      child: _HiddenGemCard(place: DummyData.place),
                    );
                  }
                  return _HiddenGemCard(place: places[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HiddenGemCard extends StatelessWidget {
  const _HiddenGemCard({required this.place});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: () {
        context.push(
          '${AppRoutes.placeDetails}?placeId=${place.id}&heroTag=home_hg_${place.id}',
          extra: place,
        );
      },
      child: SizedBox(
        width: 180.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'home_hg_${place.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppCachedImage(imagePath: place.imageUrls?.first ?? ''),
                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: FavoriteButton(
                          isFavorite: context.watch<FavoriteCubit>().isFavorite(
                            place.id,
                          ),
                          onTap: () {
                            final cubit = context.read<FavoriteCubit>();
                            cubit.toggleFavorite(
                              placeId: place.id,
                              isFavorite: !cubit.isFavorite(place.id),
                              place: place,
                            );
                          },
                        ),
                      ),
                      if (place.price != null)
                        Positioned(
                          top: 6.h,
                          right: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite.withValues(
                                alpha: 0.92,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              place.price.toString(),
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                place.name,
                style: AppTextStyles.h9Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  SvgPicture.asset(HomeAssets.locationIcon),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      place.location.address,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
