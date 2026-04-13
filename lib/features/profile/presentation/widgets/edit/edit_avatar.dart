import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    required this.imageUrl,
    required this.onCameraTap,
  });

  final String imageUrl;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: AppCachedImage(imageUrl: imageUrl),
        ),
        Positioned(
          right: -4.w,
          bottom: 6.h,
          child: InkWell(
            onTap: onCameraTap,
            borderRadius: BorderRadius.circular(19.r),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
