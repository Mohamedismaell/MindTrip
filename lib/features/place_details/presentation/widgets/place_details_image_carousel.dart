import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';

class PlaceDetailsImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  
  const PlaceDetailsImageCarousel({super.key, required this.imageUrls});

  @override
  State<PlaceDetailsImageCarousel> createState() => _PlaceDetailsImageCarouselState();
}

class _PlaceDetailsImageCarouselState extends State<PlaceDetailsImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return SizedBox(
        height: 350.h,
        width: double.infinity,
        child: Container(color: AppColors.primaryLightGray),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: 350.h,
          width: double.infinity,
          child: PageView.builder(
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return AppCachedImage(
                imagePath: widget.imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        
        // Back Button
        Positioned(
          top: MediaQuery.paddingOf(context).top + 10.h,
          left: 16.w,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: CircleAvatar(
              backgroundColor: AppColors.pureWhite.withOpacity(0.7),
              child: const Icon(Icons.arrow_back, color: AppColors.darkGray2),
            ),
          ),
        ),
        
        // Favorite Button
        Positioned(
          top: MediaQuery.paddingOf(context).top + 10.h,
          right: 16.w,
          child: CircleAvatar(
            backgroundColor: AppColors.pureWhite.withOpacity(0.7),
            child: const Icon(Icons.favorite_border, color: AppColors.darkGray2),
          ),
        ),

        // Indicator
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageUrls.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentIndex == index ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index 
                        ? AppColors.pureWhite 
                        : AppColors.pureWhite.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
