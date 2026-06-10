import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/features/home/presentation/widgets/custom_circle_icon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeTourPackages extends StatelessWidget {
  const HomeTourPackages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.tourPackagesStatus != current.tourPackagesStatus ||
          previous.tourPackages != current.tourPackages,
      builder: (context, state) {
        if (state.tourPackagesStatus == HomeDataStatus.failure) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              message: state.tourPackagesError,
              imageSize: 80,
              onPressed: () => context.read<HomeCubit>().loadTourPackages(),
            ),
          );
        }

        final isLoading =
            state.tourPackagesStatus == HomeDataStatus.loading ||
            state.tourPackagesStatus == HomeDataStatus.initial;
        final packages = isLoading
            ? DummyData.tourPackages
            : state.tourPackages;

        if (!isLoading && packages.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 233.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: packages.length,
                separatorBuilder: (_, _) => SizedBox(width: 14.w),
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return Container(
                    width: 240.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [AppShadows.tourPackagesCard],
                      color: AppColors.pureWhite,
                      border: Border.all(
                        color: context.colorTheme.outline,
                        width: 0.4,
                        // strokeAlign: 0.4,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 123.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                //image
                                AppCachedImage(imagePath: package.imageUrl),
                                //Rate badge
                                Positioned(
                                  top: 14.h,
                                  right: 14.w,
                                  child: ClipRRect(
                                    child: BackdropFilter(
                                      // blendMode: BlendMode.srcIn,
                                      filter: ImageFilter.blur(
                                        sigmaX: 4,
                                        sigmaY: 4,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              size: 24.sp,
                                              color: AppColors.customYellow,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              package.rating.toStringAsFixed(1),
                                              style:
                                                  context.textTheme.bodyMedium,
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
                          SizedBox(height: 12.h),
                          //details
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package.title,
                                  style: AppTextStyles.h8Bold.copyWith(
                                    color: context.colorTheme.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(HomeAssets.locationIcon),
                                    SizedBox(width: 8.w),
                                    Text(
                                      package.location.address,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                            color: context.colorTheme.outline,
                                          ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 17.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: package.price.toString(),
                                            style: AppTextStyles.h9Bold
                                                .copyWith(
                                                  color: context
                                                      .colorTheme
                                                      .primary,
                                                ),
                                          ),
                                          TextSpan(
                                            text: ' /person',
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                                  color: context
                                                      .colorTheme
                                                      .outline,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Todo : fix the arrow design
                                    CircleIcon(
                                      icon: HomeAssets.upTRightArrowtIcon,
                                      size: 16.sp,
                                      boxColor: AppColors.primaryLightBlue1
                                          .withValues(alpha: 0.3),
                                      isClickable: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
