import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/shared/presentation/widget/favorite_place_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoryPlacesList extends StatefulWidget {
  const HomeCategoryPlacesList({super.key});

  @override
  State<HomeCategoryPlacesList> createState() => _HomeCategoryPlacesListState();
}

class _HomeCategoryPlacesListState extends State<HomeCategoryPlacesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().loadMoreCategoryPlaces();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 400;
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
          previous.categoryPlacesStatus != current.categoryPlacesStatus ||
          previous.categoryPlaces.items != current.categoryPlaces.items ||
          previous.categoryPlaces.isMoreLoading !=
              current.categoryPlaces.isMoreLoading,
      builder: (context, state) {
        final isLoading = state.categoryPlacesStatus.isLoading;
        final places = isLoading
            ? DummyData.categoryPlaces
            : state.categoryPlaces.items;

        if (!isLoading && places.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: AppErrorWidget(
                imageSize: 130,
                message: 'No places found for this category',
                onPressed: () {
                  context.read<HomeCubit>().loadMoreCategoryPlaces();
                },
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SizedBox(
              height: 150.h,
              child: Skeletonizer(
                enabled: isLoading,
                child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount:
                      places.length +
                      (state.categoryPlaces.isMoreLoading ? 2 : 0),
                  separatorBuilder: (_, _) => SizedBox(width: 20.w),
                  itemBuilder: (context, index) {
                    if (index >= places.length) {
                      return const Skeletonizer(
                        enabled: true,
                        child: _CategoryPlaceCard(place: DummyData.place),
                      );
                    }

                    final place = places[index];
                    return _CategoryPlaceCard(place: place);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryPlaceCard extends StatelessWidget {
  const _CategoryPlaceCard({required this.place});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: () {
        context.push(
          '${AppRoutes.placeDetails}?placeId=${place.id}&heroTag=home_cat_${place.id}',
          extra: place,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: SizedBox(
          width: 205.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'home_cat_${place.id}',
                child: AppCachedImage(
                  imagePath: place.imageUrls?.first ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: FavoriteButton(placeId: place.id),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 2),
                    child: Container(
                      height: 72.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      color: Colors.black.withValues(alpha: 0.22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              style: AppTextStyles.h8Bold.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Skeleton.shade(
                                child: SvgPicture.asset(
                                  HomeAssets.locationIcon,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.primaryLightGray,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                place.location.cityEn,
                                style: AppTextStyles.h10Bold.copyWith(
                                  color: AppColors.primaryLightGray,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
