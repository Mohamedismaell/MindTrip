import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

class PlaceImages extends StatefulWidget {
  const PlaceImages({super.key, required this.photoUrls, this.heroTag});

  final List<String> photoUrls;
  final String? heroTag;

  @override
  State<PlaceImages> createState() => _PlaceImagesState();
}

class _PlaceImagesState extends State<PlaceImages> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoUrls = widget.photoUrls;
    final heroTag = widget.heroTag;

    return Column(
      children: [
        if (photoUrls.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: heroTag != null
                ? Hero(
                    tag: heroTag,
                    transitionOnUserGestures: true,
                    child: AppCachedImage(
                      imagePath: photoUrls.first,
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : AppCachedImage(
                    imagePath: photoUrls.first,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          )
        else
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.image_not_supported,
              size: 50.sp,
              color: Colors.grey,
            ),
          ),

        if (photoUrls.length > 1)
          SizedBox(
            height: 90.h,
            child: Padding(
              padding: EdgeInsets.fromLTRB(4.w, 16.h, 4.w, 0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: photoUrls.length <= 3
                    ? _buildFewImages(photoUrls)
                    : Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        thickness: 2.w,
                        child: _buildImageList(photoUrls, _scrollController),
                      ),
              ),
            ),
          ),

        SizedBox(height: 16.h),
      ],
    );
  }
}

Widget _buildFewImages(List<String> photoUrls) {
  return Row(
    children: photoUrls.map((url) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppCachedImage(
              imagePath: url,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildImageList(
  List<String> photoUrls,
  ScrollController scrollController,
) {
  return ListView.builder(
    controller: scrollController,
    scrollDirection: Axis.horizontal,
    itemCount: photoUrls.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: AppCachedImage(
            imagePath: photoUrls[index],
            width: 90.w,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
