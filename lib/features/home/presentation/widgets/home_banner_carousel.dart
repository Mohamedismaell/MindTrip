import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/shared/data/models/banner_model.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});

  final List<BannerModel> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    setState(() {
      _currentPage = (_currentPage + 1) % widget.banners.length;
    });
  }

  void _prev() {
    setState(() {
      _currentPage =
          (_currentPage - 1 + widget.banners.length) % widget.banners.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // swipe left
            _next();
          } else if (details.primaryVelocity! > 0) {
            // swipe right
            _prev();
          }
        },
        child: _buildBanner(),
      ),
    );
  }

  Widget _buildBanner() {
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
                  key: ValueKey(_currentPage),
                  imageUrl: widget.banners[_currentPage].imageUrl,
                  // fit: BoxFit.fitWidth,
                ),
              ),
            ),

            // * Could be extracted to a separate widget later i think
            //  GRADIENT
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

            // Content
            IgnorePointer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      widget.banners[_currentPage].title,
                      key: ValueKey(_currentPage),
                      style: AppTextStyles.h6SemiBold.copyWith(
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  //indectors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.banners.length, (index) {
                      final isActive = _currentPage == index;

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
