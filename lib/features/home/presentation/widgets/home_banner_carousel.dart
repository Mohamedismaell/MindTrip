import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/home/domain/entity/banner_entity.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  // final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final banners = context.read<HomeCubit>().state.banners;
      if (banners.isEmpty) return;

      setState(() {
        _currentPage = (_currentPage + 1) % banners.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    // _pageController.dispose();
    super.dispose();
  }

  void _next(int length) {
    if (length == 0) return;
    setState(() {
      _currentPage = (_currentPage + 1) % length;
    });
  }

  void _prev(int length) {
    if (length == 0) return;
    setState(() {
      _currentPage = (_currentPage - 1 + length) % length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.bannersStatus != current.bannersStatus ||
          previous.banners != current.banners,
      builder: (context, state) {
        if (state.bannersStatus.isLoading || state.bannersStatus.isInitial) {
          return SliverToBoxAdapter(
            child: Skeletonizer(
              enabled: true,
              child: _buildBanner(DummyData.banners),
            ),
          );
        }

        if (state.bannersStatus.isFailure) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              message: state.bannersError,
              imageSize: 80,
              onPressed: () => context.read<HomeCubit>().loadBanners(),
            ),
          );
        }

        final banners = state.banners;
        if (banners.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // swipe left
                _next(banners.length);
              } else if (details.primaryVelocity! > 0) {
                // swipe right
                _prev(banners.length);
              }
            },
            child: _buildBanner(banners),
          ),
        );
      },
    );
  }

  Widget _buildBanner(List<BannerEntity> banners) {
    if (banners.isEmpty) return const SizedBox.shrink();
    final index = _currentPage >= banners.length ? 0 : _currentPage;

    return SizedBox(
      height: 174.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 900),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SizedBox.expand(
                child: AppCachedImage(
                  key: ValueKey(index),
                  imagePath: banners[index].imageUrl,
                ),
              ),
            ),

            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
            IgnorePointer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              banners[index].title,
                              textAlign: TextAlign.center,
                              key: ValueKey(index),
                              style: AppTextStyles.h7SemiBold.copyWith(
                                color: AppColors.pureWhite,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80.0),
                              child: CustomOutlinedButton(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.r,
                                  horizontal: 5.r,
                                ),
                                onPressed: () {},
                                text: 'Start Now',
                                color: context.colorTheme.primary,
                                backGroundColor: AppColors.pureWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(banners.length, (i) {
                      final isActive = index == i;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: EdgeInsets.symmetric(horizontal: 3.5.w),
                        width: isActive ? 34.w : 8.w,
                        height: isActive ? 5.h : 8.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.pureWhite
                              : AppColors.primaryShadow,
                          borderRadius: BorderRadius.circular(60.r),
                        ),
                      );
                    }),
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
