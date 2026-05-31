import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

class PlaceDetailsPhotoStrip extends StatelessWidget {
  final List<String> imageUrls;

  const PlaceDetailsPhotoStrip({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final images = imageUrls.isEmpty
        ? const ['assets/images/onboarding/Pyramids.webp']
        : imageUrls;

    return SizedBox(
      height: 58.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppCachedImage(
              imagePath: images[index],
              width: 58.w,
              height: 58.h,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
