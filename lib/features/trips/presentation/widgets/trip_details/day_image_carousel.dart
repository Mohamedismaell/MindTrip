import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class DayImageCarousel extends StatefulWidget {
  const DayImageCarousel({
    super.key,
    required this.imageUrls,
    required this.fallbackAsset,
  });

  final List<String> imageUrls;
  final String fallbackAsset;

  @override
  State<DayImageCarousel> createState() => _DayImageCarouselState();
}

class _DayImageCarouselState extends State<DayImageCarousel> {
  static const _autoPlayDuration = Duration(seconds: 4);

  int _currentImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant DayImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.imageUrls.length != oldWidget.imageUrls.length &&
        _currentImageIndex >= widget.imageUrls.length &&
        widget.imageUrls.isNotEmpty) {
      setState(() {
        _currentImageIndex = 0;
      });
    }

    if (widget.imageUrls.length <= 1 && oldWidget.imageUrls.length > 1) {
      _timer?.cancel();
    } else if (widget.imageUrls.length > 1 && oldWidget.imageUrls.length <= 1) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();

    if (widget.imageUrls.length <= 1) return;

    _timer = Timer.periodic(_autoPlayDuration, (_) {
      if (!mounted) return;
      _nextImage();
    });
  }

  void _nextImage() {
    if (widget.imageUrls.length <= 1) return;

    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % widget.imageUrls.length;
    });
  }

  void _previousImage() {
    if (widget.imageUrls.length <= 1) return;

    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + widget.imageUrls.length) %
          widget.imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: SizedBox(
          width: double.infinity,
          height: 202.h,
          child: widget.fallbackAsset.isNotEmpty
              ? AppCachedImage(imagePath: widget.fallbackAsset)
              : ColoredBox(
                  color: AppColors.primaryLightGray,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 34.sp,
                      color: context.colorTheme.outline,
                    ),
                  ),
                ),
        ),
      );
    }

    final currentIndex = _currentImageIndex >= widget.imageUrls.length
        ? 0
        : _currentImageIndex;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        width: double.infinity,
        height: 202.h,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;
            if (velocity < 0) {
              _nextImage();
            } else if (velocity > 0) {
              _previousImage();
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: SizedBox.expand(
                  key: ValueKey(widget.imageUrls[currentIndex]),
                  child: AppCachedImage(
                    imagePath: widget.imageUrls[currentIndex],
                  ),
                ),
              ),
              if (widget.imageUrls.length > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.imageUrls.length, (index) {
                      final isActive = index == currentIndex;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: EdgeInsets.symmetric(horizontal: 3.5.w),
                        width: isActive ? 24.w : 8.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.pureWhite
                              : Colors.white.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(60.r),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
