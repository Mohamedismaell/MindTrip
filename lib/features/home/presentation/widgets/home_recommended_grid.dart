import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/favorite_place_button.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeRecommendedGrid extends StatelessWidget {
  const HomeRecommendedGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) =>
          previous.interests != current.interests,
      listener: (context, userState) {
        context.read<HomeCubit>().loadRecommendedPlaces(
          selectedCategories: userState.interests,
        );
      },

      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.recommendedPlacesStatus !=
                current.recommendedPlacesStatus ||
            previous.recommendedPlaces != current.recommendedPlaces,
        builder: (context, homeState) {
          if (homeState.recommendedPlacesStatus == HomeDataStatus.failure) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                message: homeState.recommendedPlacesError,
                imageSize: 80,
                onPressed: () {
                  final interests = context.read<UserCubit>().state.interests;

                  context.read<HomeCubit>().loadRecommendedPlaces(
                    selectedCategories: interests,
                  );
                },
              ),
            );
          }

          final isLoading =
              homeState.recommendedPlacesStatus == HomeDataStatus.loading ||
              homeState.recommendedPlacesStatus == HomeDataStatus.initial;
          final destinations = isLoading
              ? DummyData.recommendedPlaces
              : homeState.recommendedPlaces;

          if (!isLoading && destinations.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          return SliverGrid.builder(
            itemCount: destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 28.h,
              crossAxisSpacing: 37.w,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return Skeletonizer(
                enabled: isLoading,
                child: TapScaleEffect(
                  onTap: () {
                    if (isLoading) return;
                    context.push(
                      '${AppRoutes.placeDetails}?placeId=${destination.id}&heroTag=rec_${destination.id}',
                      extra: destination,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
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
                                      tag: 'rec_${destination.id}',
                                      child: AppCachedImage(
                                        imagePath:
                                            destination.imageUrls?.first ?? '',
                                      ),
                                    ),
                              Positioned(
                                top: 10.h,
                                left: 10.w,
                                child: FavoriteButton(placeId: destination.id),
                              ),
                              if (destination.price != null)
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
                                      destination.price.toString(),
                                      style: context.textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Text(
                          destination.name,
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
                                destination.location.address,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorTheme.outline,
                                ),
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
            },
          );
        },
      ),
    );
  }
}
