import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

class PlaceDetailsPhotoStrip extends StatefulWidget {
  final List<String> imageUrls;

  const PlaceDetailsPhotoStrip({super.key, required this.imageUrls});

  @override
  State<PlaceDetailsPhotoStrip> createState() => _PlaceDetailsPhotoStripState();
}

class _PlaceDetailsPhotoStripState extends State<PlaceDetailsPhotoStrip> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls;

    return Scrollbar(
      controller: _scrollController,
      child: SizedBox(
        height: 73.h,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: images.length,
          separatorBuilder: (context, index) => SizedBox(width: 14.w),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AppCachedImage(
                imagePath: images[index],
                width: 73.w,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
