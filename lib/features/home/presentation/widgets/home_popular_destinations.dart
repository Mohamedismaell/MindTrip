import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/favorite_place_button.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';

class HomePopularDestinations extends StatefulWidget {
  const HomePopularDestinations({super.key});

  @override
  State<HomePopularDestinations> createState() =>
      _HomePopularDestinationsState();
}

class _HomePopularDestinationsState extends State<HomePopularDestinations> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeCubit>().loadMorePopularPlaces();
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
          previous.popularPlacesStatus != current.popularPlacesStatus ||
          previous.popularPlaces != current.popularPlaces ||
          previous.popularPlacesIsMoreLoading !=
              current.popularPlacesIsMoreLoading,

      builder: (context, state) {
        if (state.popularPlacesStatus.isFailure) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              message: state.popularPlacesError,
              imageSize: 80,
              onPressed: () =>
                  context.read<HomeCubit>().loadFirstPagePopularPlaces(),
            ),
          );
        }
        final isLoading =
            state.popularPlacesStatus.isLoading ||
            state.popularPlacesStatus.isInitial;
        final destinations = isLoading
            ? DummyData.popularPlaces
            : state.popularPlaces;

        if (!isLoading && destinations.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 198.h,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount:
                    destinations.length +
                    (state.popularPlacesIsMoreLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == destinations.length) {
                    return SizedBox(
                      width: 100.w,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  final destination = destinations[index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 289.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.r),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              //! Handle no image later
                              Skeletonizer.maybeOf(context)?.enabled ?? false
                                  ? AppCachedImage(
                                      imagePath:
                                          destination.imageUrls?.first ?? '',
                                    )
                                  : Hero(
                                      tag: 'pop_${destination.id}',
                                      child: AppCachedImage(
                                        imagePath:
                                            destination.imageUrls?.first ?? '',
                                      ),
                                    ),

                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),

                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                child: Container(color: Colors.transparent),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  right: 20.w,
                                  left: 20.w,
                                  top: 30.h,
                                  bottom: 20.h,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          destination.name,
                                          style: context
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                color: AppColors.pureWhite,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          destination.location.cityEn,
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                                color:
                                                    AppColors.primaryLightGray,
                                              ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        for (final previewImageUrl
                                            in (destination.imageUrls ?? [])
                                                .take(2)) ...[
                                          _PreviewImageTile(
                                            imageUrl: previewImageUrl,
                                          ),
                                          SizedBox(width: 8.w),
                                        ],
                                        if ((destination.imageUrls?.length ??
                                                0) >
                                            2)
                                          _ExtraPhotosTile(
                                            extraPhotoCount:
                                                (destination
                                                        .imageUrls
                                                        ?.length ??
                                                    0) -
                                                2,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                top: 20.h,
                                right: 20.w,
                                child: FavoriteButton(
                                  placeId: destination.id,
                                  backgroundColor: AppColors.pureWhite
                                      .withValues(alpha: 0.3),
                                  showShadow: false,
                                ),
                              ),

                              Positioned(
                                bottom: 20.h,
                                right: 20.w,
                                child: TapScaleEffect(
                                  onTap: () {
                                    if (isLoading) return;
                                    context.push(
                                      '${AppRoutes.placeDetails}?placeId=${destination.id}&heroTag=pop_${destination.id}',
                                      extra: destination,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.pureWhite.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(12.r),
                                    child: SizedBox(
                                      width: 20.sp,
                                      height: 20.sp,
                                      child: SvgPicture.asset(
                                        HomeAssets.upTRightArrowtIcon,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PreviewImageTile extends StatelessWidget {
  const _PreviewImageTile({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: SizedBox(
        width: 47.r,
        height: 47.r,
        child: AppCachedImage(imagePath: imageUrl),
      ),
    );
  }
}

class _ExtraPhotosTile extends StatelessWidget {
  const _ExtraPhotosTile({required this.extraPhotoCount});

  final int extraPhotoCount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: 47.r,
          height: 47.r,
          alignment: Alignment.center,
          color: AppColors.pureWhite.withValues(alpha: 0.1),
          child: Text(
            '+$extraPhotoCount',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ),
    );
  }
}
